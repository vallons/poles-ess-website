# frozen_string_literal: true

module FormationHelper

  def formation_category_options(formation_categories = FormationCategory.all)
    formation_categories.order(title: :asc).map do |formation_category|
      [formation_category.title, formation_category.id]
    end
  end

  def formation_options(formations = Formation.all)
    formations.order(title: :asc).map do |formation|
      [formation_display_title(formation), formation.id]
    end
  end

  def formation_display_title(formation)
    [formation&.start_date&.year, formation.title.truncate(150)].join(" - ")
  end

  def formation_location(session)
    full_city = [session.zipcode, session.city].join(" ")
    [session.address, full_city].join(", ")
  end

  def formation_dates(session)
    session.schedules.map{ |schedule| formation_date(schedule) }.to_sentence(words_connector: ', ', last_word_connector: ' et ')
  end

  def formation_date(schedule)
    return "" if schedule.date.blank?
    day = I18n.l(schedule.date.to_date, format: :long_with_day)
    start_at = I18n.l(schedule.start_at, format: :time)
    end_at = I18n.l(schedule.end_at, format: :time)
    hours = [start_at, end_at].join(" à ")
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
