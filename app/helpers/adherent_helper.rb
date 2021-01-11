# frozen_string_literal: true
module AdherentHelper
  def adherent_category_options(adherent_categories = AdherentCategory.all)
    adherent_categories.order(title: :asc).map do |adherent_category|
      [adherent_category.title, adherent_category.id]
    end
  end

  def adherent_options(adherents = Adherent.all)
    adherents.order(title: :asc).map do |adherent|
      [adherent.title, adherent.id]
    end
  end
end
