class ActivitiesController < ApplicationController

  include SlugsAndRedirections

  before_action :get_activity, only: [:show]

  def show
  end

  private # =====================================================

  def get_activity
    @activity = get_object_from_param_or_redirect(Activity)
  end
 
end
