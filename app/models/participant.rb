class Participant < ApplicationRecord

  belongs_to :subscription, inverse_of: :participants
  has_one :formation, through: :subscription

  # Enums =================================

  enum status: {
    participation_confirmed: 0,
    in_waiting_line: 1
  }

  # Validations ================================================================

  validates :lastname, :firstname, :email,
            presence: true

  # Scopes ====================================================================

  scope :by_formation, -> (val) {
    eager_load(:subscription)
    .where(arel_by_formation(val))
  }

  scope :by_participant, -> (val) {
    eager_load(:subscription)
    .where(arel_by_participant(val))
  }

  def self.arel_by_formation(val)
    FormationSubscription.arel_table[:formation_id].eq(val)
  end

  def self.arel_by_participant(val)
    FormationSubscription.arel_table[:participant_id].eq(val)
  end

  # Instance methods ====================================================

  # Class Methods ==============================================================

  def self.apply_filters(params)
    [
      :by_formation,
      :by_participant
    ].inject(all) do |relation, filter|
      next relation unless params[filter].present?
      relation.send(filter, params[filter])
    end
  end

  def self.apply_sorts(params)
    self.order(created_at: :desc)
  end

end
