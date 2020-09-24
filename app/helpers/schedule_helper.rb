
module ScheduleHelper

  def schedule_dates(dates)
    dates.map{ |date| I18n.l(date.first.to_date, format: :default) }.join(" & ")
  end
end