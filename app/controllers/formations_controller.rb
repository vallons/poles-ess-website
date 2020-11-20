class FormationsController < ApplicationController

  include SlugsAndRedirections

  before_action :get_formation, only: [:show]

  def index
    @all_formation_categories = FormationCategory.enabled.order(:position)
    @formations = Formation.enabled.includes(:formation_category, :seo)
    .apply_filters(params)
    if params[:sort] == 'by_future'
      @formations = @formations.sort_by_future.sort_by_start_date
    else
      @formations = @formations.in_most_recent_year.sort_by_formation_category
    end
  end

  def show
  end

  private # =====================================================

  def get_formation
    @formation = get_object_from_param_or_redirect(Formation)
  end

end
