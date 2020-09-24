class Formation < ApplicationRecord

  include Seoable

  has_rich_text :description
  has_one_attached :image

  belongs_to :formation_category
  has_many :schedules, as: :schedulable

  # Validations ================================================================

  validates :title, :formation_category,
            presence: true

  # Scopes ====================================================================

  scope :by_formation_category, -> (val) {
    where(formation_category_id: val)
  }

  scope :sort_by_start_date, -> {
   joins(:schedules).merge(Schedule.sort_by_start_date)
  }

  # Instance methods ====================================================

  def start_date
    schedules.first.time_range.first
  end

  # Class Methods ==============================================================

  def self.apply_filters(params)
    [
      :by_formation_category,
    ].inject(all) do |relation, filter|
      next relation unless params[filter].present?
      relation.send(filter, params[filter])
    end
  end

  def self.apply_sorts(params)
      self.order(created_at: :desc)
  end

end
