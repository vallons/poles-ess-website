# frozen_string_literal: true

module PostHelper

  def post_category_options(post_categories = PostCategory.all)
    post_categories.order(title: :asc).map do |post_category|
      [post_category.title, post_category.id]
    end
  end

  def parent_page_options(parent_pages = MainPage.no_parent)
    parent_pages.order(position: :asc).map do |parent_page|
      [parent_page.title, parent_page.id]
    end
  end

  def post_options(posts = Post.all)
    posts.order(title: :asc).map do |post|
      [post.title, post.id]
    end
  end

end
