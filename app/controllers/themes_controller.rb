class ThemesController < ApplicationController

  include SlugsAndRedirections

  before_action :get_theme, only: [:show]

  def show
  end

  private # =====================================================

  def get_theme
    @theme = get_object_from_param_or_redirect(Theme)
  end
 
end
