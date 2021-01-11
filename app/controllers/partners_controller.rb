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
    @breadcrumbs = []
    @breadcrumbs << [ "Accueil",    root_path ]
    @breadcrumbs << [ "Le pôle",    main_page_path(MainPage.find_by(title: "Le pôle")) ]
    @breadcrumbs << [ "Partenaires",      partners_path ]
  end
end
