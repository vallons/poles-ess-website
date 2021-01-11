# frozen_string_literal: true
module PartnerHelper
  def partner_category_options(partner_categories = PartnerCategory.all)
    partner_categories.order(title: :asc).map do |partner_category|
      [partner_category.title, partner_category.id]
    end
  end

  def partner_options(partners = Partner.all)
    partners.order(title: :asc).map do |partner|
      [partner.title, partner.id]
    end
  end
end
