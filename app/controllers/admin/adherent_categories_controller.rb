# frozen_string_literal: true
class Admin::AdherentCategoriesController < Admin::BaseController

  before_action :get_adherent_category, only: [:edit, :update, :destroy]

  def index
    @adherent_categories = AdherentCategory.order(:position)
      # .page(params[:page]).per(20)
  end

  def new
    @adherent_category = AdherentCategory.new
    @adherent_category.build_seo
  end

  def create
    @adherent_category = AdherentCategory.new(adherent_category_params)
    if @adherent_category.save
      flash[:notice] = "La catégorie a été créé avec succès"
      redirect_to params[:continue].present? ? edit_admin_adherent_category_path(@adherent_category) : admin_adherent_categories_path
    else
      flash[:error] = "Une erreur s'est produite lors de la mise à jour de la catégorie"
      render :new
    end
  end

  def edit
  end

  def update
    if @adherent_category.update(adherent_category_params)
      flash[:notice] = "Catégorie mise à jour avec succès"
      redirect_to params[:continue].present? ? edit_admin_adherent_category_path(@adherent_category) : admin_adherent_categories_path
    else
      flash[:error] = "Une erreur s'est produite lors de la mise à jour de la catégorie"
      render :edit
    end
  end

  def destroy
    begin
      @adherent_category.destroy!
      flash[:notice] = "La catégorie a été supprimé avec succès"
    rescue ActiveRecord::DeleteRestrictionError
      flash[:error] = "Vous ne pouvez pas supprimer cette catégorie car elle a des données dépendantes"
    end
    redirect_to action: :index
  end

  private # =====================================================

  def adherent_category_params
    params.require(:adherent_category).permit(:title, :position, :enabled,
        seo_attributes: seo_attributes)
  end

  def get_adherent_category
    @adherent_category = AdherentCategory.from_param params[:id]
  end
end
