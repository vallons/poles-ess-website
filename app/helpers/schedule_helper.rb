
module ScheduleHelper

  def schedule_dates(dates)
    dates.map{ |date| I18n.l(date.first.to_date, format: :default) }.join(" & ")
  end

  def schedule_day(schedule, format: :long_with_day)
   I18n.l(schedule.date.to_date, format: format)
  end

  def schedule_time(schedule)
    start_at = I18n.l(schedule.start_at, format: :time)
    end_at = I18n.l(schedule.end_at, format: :time)
    [start_at, end_at].join(" à ")
  end

end