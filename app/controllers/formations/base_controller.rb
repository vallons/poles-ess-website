class Formations::BaseController < ApplicationController
  before_action :get_formation
  before_action :set_base_breadcrumbs

  private

  def get_formation
    @formation = Formation.from_param(params[:formation_id])
  end

  def set_base_breadcrumbs
    @breadcrumbs = []
    @breadcrumbs << [ "Accueil", root_path ]
    @breadcrumbs << [ "Formations", formations_path ]
    @breadcrumbs << [ @formation.title, formation_path(@formation) ]
  end
end
