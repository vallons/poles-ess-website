class ActivitiesController < ApplicationController

  include SlugsAndRedirections
  include Breadcrumbs

  before_action :get_activity, only: [:show]

  def index
    @activity_themes = Theme.enabled.having_activities.order(:position)
    @activity_profiles = Profile.enabled.having_activities.order(:position)
    @activities = Activity.enabled.includes(:themes, :profiles).apply_filters(params).order(title: :asc)
  end

  def show
  end

  private # =====================================================

  def get_activity
    @activity = get_object_from_param_or_redirect(Activity)
    @breadcrumbs << [ @activity.title, activity_path(@activity) ]
  end

  def set_specific_breadcrumbs
    @breadcrumbs << [ "Actions", activities_path ]
  end
end
