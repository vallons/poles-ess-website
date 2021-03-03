class PostCategoriesController < ApplicationController
  include SlugsAndRedirections

  def show
    @post_category = get_object_from_param_or_redirect(PostCategory)
    redirect_to posts_path(by_post_category: @post_category.id)
  end

  private # =====================================================
end
