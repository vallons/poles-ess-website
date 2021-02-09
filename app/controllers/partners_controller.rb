class PartnersController < ApplicationController
  include SlugsAndRedirections

  before_action :set_breadcrumbs

  def index
    @partner_categories = PartnerCategory.having_partners.includes(:partners).order(:position)
  end

  private # =====================================================

  def get_partner
    @partner = get_object_from_param_or_redirect(Partner)
  end

  def set_breadcrumbs
    parent_page = MainPage.find_by(key: "partner").parent_page
    @breadcrumbs = []
    @breadcrumbs << [ "Accueil",    root_path ]
    @breadcrumbs << [ parent_page.title,    main_page_path(parent_page) ] if parent_page.present?
    @breadcrumbs << [ "Partenaires",      partners_path ]
  end
end
