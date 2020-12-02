class ResourcesController < ApplicationController

  def index
    @resources = Resource.apply_filters(params).order(:created_at)
    @themes = Theme.enabled.order(:position)
  end

  private # =====================================================

  def get_post
    @post = get_object_from_param_or_redirect(Post)
  end


end
