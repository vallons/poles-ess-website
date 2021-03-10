class BasicPagesController < ApplicationController

  include SlugsAndRedirections

  before_action :get_basic_page, only: [:show]
  before_action :set_breadcrumbs

  def show
  end

  private # =====================================================

  def get_basic_page
    @basic_page = get_object_from_param_or_redirect(BasicPage)
  end

  def set_breadcrumbs
    @breadcrumbs = []
    @breadcrumbs << [ "Accueil", root_path ]
    @breadcrumbs << [ @basic_page.title, basic_page_path(@basic_page) ]
  end
end
