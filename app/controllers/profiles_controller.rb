class ProfilesController < ApplicationController

  include SlugsAndRedirections
  include Breadcrumbs

  before_action :get_profile, only: [:show]

  def show
  end

  private # =====================================================

  def get_profile
    @profile = get_object_from_param_or_redirect(Profile)
    @breadcrumbs << [ @profile.title, profile_path(@profile) ]
  end
end
