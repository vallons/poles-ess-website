class AgendaItemDecorator < SimpleDelegator
  include Rails.application.routes.url_helpers

  def date
    time_range.begin
  end

  def title
    schedulable.title
  end

  def l_date
    date.strftime("%d %b %Y")
  end

  def day
    date.strftime("%d")
  end

  def month
    I18n.l(date, format: '%B')
  end

  def year
    date.strftime("%Y")
  end

  def url
    if schedulable.is_a?(Formation)
      formation_path(schedulable)
    elsif schedulable.is_a?(Event)
      schedulable.link
    end
  end

  def enabled?
    if schedulable.is_a?(Formation)
      schedulable.enabled
    else
      true
    end
  end


end