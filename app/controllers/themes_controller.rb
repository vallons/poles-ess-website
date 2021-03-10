class ThemesController < ApplicationController
  include SlugsAndRedirections
  include Breadcrumbs

  before_action :get_theme, only: [:show]

  def show
  end

  private # =====================================================

  def get_theme
    @theme = get_object_from_param_or_redirect(Theme)
    @breadcrumbs << [ @theme.title, theme_path(@theme) ]
  end
end
