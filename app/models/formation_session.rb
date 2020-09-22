class FormationSession < ApplicationRecord

  belongs_to :formation
  has_many :schedules, as: :schedulable

  # Validations ================================================================


  # Scopes ====================================================================

  scope :by_formation, -> (val) {
    where(formation_id: val)
  }

  # Instance methods ====================================================

   # Class Methods ==============================================================

  def self.apply_filters(params)
    [
      :by_formation,
    ].inject(all) do |relation, filter|
      next relation unless params[filter].present?
      relation.send(filter, params[filter])
    end
  end

  def self.apply_sorts(params)
      self.order(created_at: :desc)
  end

end
