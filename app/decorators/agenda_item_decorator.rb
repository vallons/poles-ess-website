class AgendaItemDecorator < SimpleDelegator
  include Rails.application.routes.url_helpers

  def date
    schedules.first.time_range.begin
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
    end
  end


end