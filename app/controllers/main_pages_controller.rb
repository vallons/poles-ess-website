class MainPagesController < ApplicationController

  include SlugsAndRedirections

  before_action :get_main_page, only: [:show]
  before_action :set_breadcrumbs

  def show
    redirect_to polymorphic_path(@main_page.key.classify.constantize) if @main_page.special_page?
  end

  private # =====================================================

  def get_main_page
    @main_page = get_object_from_param_or_redirect(MainPage)
  end

  def set_breadcrumbs
    parent_page =  @main_page.parent_page
    @breadcrumbs = []
    @breadcrumbs << [ "Accueil", root_path ]
    @breadcrumbs << [ parent_page.title, main_page_path(parent_page) ] if parent_page.present?
    @breadcrumbs << [ @main_page.title, main_page_path(@main_page) ]
  end
end
