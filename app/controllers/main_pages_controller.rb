class MainPagesController < ApplicationController

  include SlugsAndRedirections

  before_action :get_main_page, only: [:show]

  def show
    redirect_to polymorphic_path(@main_page.key.classify.constantize) if @main_page.special_page?
  end

  private # =====================================================

  def get_main_page
    @main_page = get_object_from_param_or_redirect(MainPage)
  end
end
