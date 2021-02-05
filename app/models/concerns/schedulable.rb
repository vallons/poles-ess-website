# frozen_string_literal: true
module Schedulable
  extend ActiveSupport::Concern

  included do
    has_many :schedules, -> {order(:time_range)}, as: :schedulable, inverse_of: :schedulable, dependent: :destroy
    has_one :first_schedule, -> {order(:time_range)}, as: :schedulable, inverse_of: :schedulable, class_name: 'Schedule'
    accepts_nested_attributes_for :schedules, reject_if: :all_blank, allow_destroy: true

    scope :newest_first, -> {
     eager_load(:first_schedule).merge(Schedule.newest_first)
    }
    scope :oldest_first, -> {
      eager_load(:first_schedule).merge(Schedule.sort_by_start_date)
    }
    scope :sort_by_start_date, -> {
      eager_load(:first_schedule).merge(Schedule.sort_by_start_date)
    }
    scope :sort_by_future, -> {
      eager_load(:first_schedule).merge(Schedule.future)
    }
    scope :in_most_recent_year, -> {
      eager_load(:first_schedule).merge(Schedule.in_most_recent_year)
    }
    scope :by_year, -> (year) {
      eager_load(:first_schedule).merge(Schedule.by_year(year)).references(:schedules)
    }
  end

  def start_date
    schedules.first.time_range.first
  end

  def future?
    schedules.first.future?
  end
end
