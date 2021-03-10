class ResourcesController < ApplicationController
  include Breadcrumbs

  def index
    @resources = Resource.enabled.apply_filters(params).order(:created_at).page(params[:page]).per(20)
    @resource_themes = Theme.enabled.having_resources.order(:position)
    @resource_profiles = Profile.enabled.having_resources.order(:position)
  end

  private # =====================================================

  def set_specific_breadcrumbs
    @breadcrumbs << [ "Ressources", resources_path ]
  end
end
