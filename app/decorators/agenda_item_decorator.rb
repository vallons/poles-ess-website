class AgendaItemDecorator < SimpleDelegator
  include Rails.application.routes.url_helpers

  def date
    if respond_to? :schedules
      schedules.first.time_range.begin
    else
      schedule.time_range.begin
    end
  end

  def l_date
    date.strftime("%d %b %Y")
  end

  def day
    date.strftime("%d")
  end

  def month
    date.strftime("%b")
  end

  def year
    date.strftime("%Y")
  end

  def url
    if self.__getobj__.is_a?(Formation)
      formation_path(self)
    elsif self.__getobj__.is_a?(Event)
      link
    end
  end


end