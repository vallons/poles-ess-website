class Event < ApplicationRecord

  include Seoable
  include Enablable

  has_one :schedule, -> {order(:time_range)}, as: :schedulable, inverse_of: :schedulable, dependent: :destroy
  accepts_nested_attributes_for :schedule, reject_if: :all_blank, allow_destroy: true

  # Validations ================================================================

  validates :title, :schedule,
            presence: true

  # Scopes ====================================================================
  
    scope :newest_first, -> {
     eager_load(:schedule).merge(Schedule.newest_first)
    }

  scope :oldest_first, -> {
    eager_load(:schedule).merge(Schedule.sort_by_start_date)
  }

  scope :sort_by_future, -> {
   eager_load(:schedule).merge(Schedule.future)
  }

  # Instance methods ====================================================

  def start_date
    schedule.time_range.first
  end

  def future?
    schedule.future?
  end

  # Class Methods ==============================================================

end
