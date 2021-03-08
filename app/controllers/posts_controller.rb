class PostsController < ApplicationController
  include SlugsAndRedirections

  before_action :get_post, only: [:show]
  before_action :set_base_breadcrumbs

  def index
    @post_categories = PostCategory.enabled.having_posts.order(:position)
    @post_themes = Theme.enabled.having_posts.order(:position)
    @post_profiles = Profile.enabled.having_posts.order(:position)
    @posts = Post.published.apply_filters(params).order(published_at: :desc).page(params[:page]).per(8)
  end

  def show
    if @post.publication_state != :published && current_admin.blank?
      redirect_to(root_path)
      return
    end
    @breadcrumbs << [ @post.title,  post_path(@post) ]

    @other_posts = get_other_posts(@post)
  end

  private # =====================================================
  def get_post
    @post = get_object_from_param_or_redirect(Post)
  end

  def get_other_posts(post)
    if @category = @post.post_category
      posts = @category.posts
    elsif @theme = @post.themes.first
      posts = @theme.posts
    else
      posts = Post.order(Arel.sql('RANDOM()'))
    end
    posts.where.not(id: post.id).includes(:seo).limit(2)
  end

  def set_base_breadcrumbs
    @breadcrumbs = []
    @breadcrumbs << [ "Accueil",         root_path ]
    @breadcrumbs << [ "Actualités",      posts_path ]
  end

end
