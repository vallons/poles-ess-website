class BasicPagesController < ApplicationController

  include SlugsAndRedirections

  before_action :get_basic_page, only: [:show]

  def show
  end

  private # =====================================================

  def get_basic_page
    @basic_page = get_object_from_param_or_redirect(BasicPage)
  end
 
end
