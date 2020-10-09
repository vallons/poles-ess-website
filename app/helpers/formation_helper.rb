# frozen_string_literal: true

module FormationHelper

  def formation_category_options(formation_categories = FormationCategory.all)
    formation_categories.order(title: :asc).map do |formation_category|
      [formation_category.title, formation_category.id]
    end
  end

  def formation_year_options
    Formation.all.map do |formation|
      [formation.first_schedule.time_range.begin.year, formation.first_schedule.time_range.begin.year]
    end.uniq
  end

  def formation_options(formations = Formation.all)
    formations.order(title: :asc).map do |formation|
      [formation_display_title(formation), formation.id]
    end
  end

  def formation_display_title(formation)
    [formation&.start_date&.year, formation.title.truncate(150)].join(" - ")
  end

  def formation_location(formation)
    full_city = [formation.zipcode, formation.city].join(" ")
    [formation.address, full_city].join(", ")
  end

  def formation_dates(formation)
    schedules = formation.schedules
    if schedules.same_times?
      days = schedules.map{ |schedule| schedule_day(schedule) }.join(" & ")
      hours = schedule_time(schedules.first)
      [days, hours].join(", ")
    else
      schedules.map{ |schedule| formation_date(schedule) }.join(" & ")
    end
  end

  def formation_date(schedule)
    return "" if schedule.date.blank?
    day = schedule_day(schedule)
    hours = schedule_time(schedule)
    [day, hours].join(", ")
  end

  def formation_tickets_status(formation)
    count = formation.is_full? ? 0 : formation.remaining_tickets
    I18n.t(:tickets, count: count)
  end

  def fields_for_opened_detail?(ff)
    ff.index == 0 || ff.object.model.persisted?
  end

end
