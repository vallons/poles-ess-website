class Formations::BaseController < ApplicationController
  before_action :get_formation

  private

  def get_formation
    @formation = Formation.from_param(params[:formation_id])
  end

end