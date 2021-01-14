class ProfilesController < ApplicationController

  include SlugsAndRedirections

  before_action :get_profile, only: [:show]

  def show
  end

  private # =====================================================

  def get_profile
    @profile = get_object_from_param_or_redirect(Profile)
  end
 
end
