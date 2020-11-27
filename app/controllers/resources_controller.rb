class ResourcesController < ApplicationController

  def index
    @resources = Resource.order(:created_at)
    @themes = Theme.order(:position)
  end

  private # =====================================================

  def get_post
    @post = get_object_from_param_or_redirect(Post)
  end


end
