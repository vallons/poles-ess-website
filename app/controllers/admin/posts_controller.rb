# frozen_string_literal: true

class Admin::PostsController < Admin::BaseController
  before_action :get_post, only: [:edit, :update, :destroy, :sort_picture]

  def index
    params[:sort] ||= "sort_by_published_at desc"
    @posts = Post
      .includes(:seo, :themes, :post_category)
      .apply_filters(params).apply_sorts(params)
    # @pagy, @posts = pagy(Post.apply_filters(params))
  end

  def new
    @post = Post.new(published_at: Time.current)
    @post.build_seo
  end

  def create
    @post = Post.new(post_params)

    if @post.save
      flash[:notice] = "L'actualité a été créée avec succès"
      redirect_to params[:continue].present? ? edit_admin_post_path(@post) : admin_posts_path
    else
      flash[:error] = "Une erreur s'est produite lors de la création de l'actualité"
      render :new
    end
  end
  
  def edit
  end
  
  def update
    if @post.update_attributes(post_params)
      flash[:notice] = "L'actualité a été mise à jour avec succès"
      redirect_to params[:continue].present? ? edit_admin_post_path(@post) : admin_posts_path
    else
      p "error ================================="
      flash[:error] = "Une erreur s'est produite lors de la mise à jour de l'actualité"
      render :edit
    end
  end

  def destroy
    begin
      flash[:notice] = "L'actualité a bien été supprimée" if @post.destroy
    rescue ActiveRecord::DeleteRestrictionError
      flash[:error] = "Cette actualité ne peut être supprimée car des éléments lui sont dépendants"
    end
    redirect_to admin_posts_path
  end

  def picture_form
    render partial: "picture_form", locals: { time: Time.current.to_i }
  end

  def sort_picture
    picture = @post.pictures.find(params[:picture_id])
    picture.insert_at(params[:position].to_i)
    render partial: "picture_list"
  end

  private

  def get_post
    @post = Post.from_param params[:id]
  end

  def post_params
    params
      .require(:post)
      .permit(
        :post_category_id,
        :title,
        :description,
        :image,
        :published_at,
        :expired_at,
        theme_ids: [],
        seo_attributes: seo_attributes
      )
  end
end
