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

  # Callbacks ===================================================================

  before_validation :set_status, on: :create

  private def set_status
    # la subscription n'est pas encore créée donc pas de lien direct avec formation
    self.status = :in_waiting_line if self.subscription.formation.is_full?
  end

  # Scopes ====================================================================

  scope :by_formation, -> (val) {
    eager_load(:subscription)
    .where(arel_by_formation(val))
  }

  scope :by_participant, -> (val) {
    eager_load(:subscription)
    .where(arel_by_participant(val))
  }

  scope :by_status, ->(status) {
    where(status: statuses.fetch(status.to_sym))
  }

  def self.arel_by_formation(val)
    Subscription.arel_table[:formation_id].eq(val)
  end

  def self.arel_by_participant(val)
    Subscription.arel_table[:participant_id].eq(val)
  end

  # Instance methods ====================================================

  # Class Methods ==============================================================

  def self.apply_filters(params)
    [
      :by_formation,
      :by_participant,
      :by_status
    ].inject(all) do |relation, filter|
      next relation unless params[filter].present?
      relation.send(filter, params[filter])
    end
  end

  def self.apply_sorts(params)
    self.order(created_at: :desc)
  end

end
