class FormationsController < ApplicationController

  include SlugsAndRedirections

  before_action :get_formation, only: [:show]

  def index
    @formation_categories = FormationCategory.order(:position)
    @formations = Formation
      .apply_filters(params)
      .apply_sorts(params)
      # .page(params[:page]).per(20)
  end

  def show
  end

  private # =====================================================

  def get_formation
    @formation = get_object_from_param_or_redirect(Formation)
  end
 
end
