class Schedule < ApplicationRecord

  attr_accessor :date, :start_at, :end_at

  belongs_to :schedulable, polymorphic: true

  # Validations ================================================================

  before_validation :set_time_range#, unless: -> { self.time_range.present? }
  validate :validate_time_range, if: -> { self.time_range.present? }
  # validates :time_range, :schedulable, presence: true


  # Scopes ====================================================================

  scope :future, -> {
    where("lower(time_range) > ?", Time.zone.now)
  }

  scope :past, -> {
    where("lower(time_range) < ?", Time.zone.now)
  }

  scope :today, ->    { between_datetime(Time.zone.now.beginning_of_day, Time.zone.now.end_of_day) }
  scope :tomorrow, -> { between_datetime(Time.zone.now.tomorrow.beginning_of_day, Time.zone.now.tomorrow.end_of_day) }
  scope :this_week, -> { between_datetime(Time.zone.now.beginning_of_week, Time.zone.now.end_of_week) }

  # ex: time = 72.hours or time = 5.days
  scope :in_time, -> (time) {
    between_datetime((Time.zone.now + time).beginning_of_day, (Time.zone.now + time).end_of_day)
  }
  scope :between_datetime, -> (start_date, end_date) {
    raise ArgumentError unless start_date.is_a?(Time)
    raise ArgumentError unless end_date.is_a?(Time)

    overlap(TimeRange.new(start_date.beginning_of_day, end_date.end_of_day))
  }

  scope :by_start_date, -> (date) {
    where('lower(time_range)::date >= ?', date.to_date)
  }

  scope :by_end_date, -> (date) {
    where('lower(time_range)::date <= ?', date.to_date)
  }

  scope :sort_by_start_date, -> {
   order(:time_range)
  }

  # Class Methods ==============================================================

  def self.apply_filters(params)
    [
      :by_start_date,
    ].inject(all) do |relation, filter|
      next relation unless params[filter].present?
      relation.send(filter, params[filter])
    end
  end

  def self.apply_sorts(params)
    self.order(created_at: :desc)
  end

# Instance methods ====================================================

  def date
    if @date.is_a?(ActiveSupport::TimeWithZone)
      @date
    elsif @date.is_a?(String)
      Time.zone.parse @date
    elsif self.time_range.present?
      self.time_range.first.at_midnight
    end
  end

  def start_at
    if @start_at.is_a?(ActiveSupport::TimeWithZone)
      @start_at
    elsif @start_at.is_a?(String)
      Time.zone.parse @start_at
    elsif self.time_range.present?
      self.time_range.first
    end
  end

  def end_at
    if @end_at.is_a?(ActiveSupport::TimeWithZone)
      @end_at
    elsif @end_at.is_a?(String)
      Time.zone.parse @end_at
    elsif self.time_range.present?
      self.time_range.last
    end
  end

  def duration_in_minutes
    if @duration_in_minutes.is_a?(String)
      @duration_in_minutes.try :to_i
    elsif self.time_range.present?
      ((self.time_range.last - self.time_range.first) / 60).to_i
    else
      @duration_in_minutes
    end
  end

  def future?
    self.time_range.present? && (self.time_range.first > Time.zone.now)
  end

  def past?
    self.time_range.present? && !self.future?
  end

  private

  def set_time_range
    if self.start_at.present? && self.end_at.present? && self.date.present?
      start_at = self.date + (Time.zone.parse(self.start_at.to_s)).seconds_since_midnight
      end_at = self.date + self.end_at.to_datetime.seconds_since_midnight
      self.time_range = TimeRange.new(start_at, end_at)
    end
  end

  def validate_time_range
    if self.time_range.first >= self.time_range.last
      errors.add(:base, "L'heure de début doit être avant l'heure de fin.")
    end
  end


end
