# frozen_string_literal: true

class Admin::PostCategoriesController < Admin::BaseController

  before_action :get_post_category, only: [:edit, :update, :destroy]

  def index
    @post_categories = PostCategory.order(:position)
      # .page(params[:page]).per(20)
  end

  def new
    @post_category = PostCategory.new
    @post_category.build_seo
  end

  def create
    @post_category = PostCategory.new(post_category_params)
    if @post_category.save
      flash[:notice] = "La catégorie a été créé avec succès"
      redirect_to params[:continue].present? ? edit_admin_post_category_path(@post_category) : admin_post_categories_path
    else
      flash[:error] = "Une erreur s'est produite lors de la mise à jour de la catégorie"
      render :new
    end
  end

  def edit
  end

  def update
    if @post_category.update(post_category_params)
      flash[:notice] = "Catégorie mise à jour avec succès"
      redirect_to params[:continue].present? ? edit_admin_post_category_path(@post_category) : admin_post_categories_path
    else
      flash[:error] = "Une erreur s'est produite lors de la mise à jour de la catégorie"
      render :edit
    end
  end

  def destroy
    begin
      @post_category.destroy!
      flash[:notice] = "La catégorie a été supprimé avec succès"
    rescue ActiveRecord::DeleteRestrictionError
      flash[:error] = "Vous ne pouvez pas supprimer cette catégorie car elle a des données dépendantes"
    end
    redirect_to action: :index
  end

  private # =====================================================

  def post_category_params
    params.require(:post_category).permit(:title, :position,
        seo_attributes: seo_attributes)
  end

  def get_post_category
    @post_category = PostCategory.from_param params[:id]
  end
 
end
