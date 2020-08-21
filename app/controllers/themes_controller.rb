class ThemesController < ApplicationController

  before_action :find_theme, only: [:show]

  def show
  end

  private # =====================================================

  def find_theme
    @theme = Theme.find(params[:id])
  end
 
end
