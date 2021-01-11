# frozen_string_literal: true
class Admin::PartnerCategoriesController < Admin::BaseController

  before_action :get_partner_category, only: [:edit, :update, :destroy]

  def index
    @partner_categories = PartnerCategory.order(:position)
      # .page(params[:page]).per(20)
  end

  def new
    @partner_category = PartnerCategory.new
    @partner_category.build_seo
  end

  def create
    @partner_category = PartnerCategory.new(partner_category_params)
    if @partner_category.save
      flash[:notice] = "La catégorie a été créé avec succès"
      redirect_to params[:continue].present? ? edit_admin_partner_category_path(@partner_category) : admin_partner_categories_path
    else
      flash[:error] = "Une erreur s'est produite lors de la mise à jour de la catégorie"
      render :new
    end
  end

  def edit
  end

  def update
    if @partner_category.update(partner_category_params)
      flash[:notice] = "Catégorie mise à jour avec succès"
      redirect_to params[:continue].present? ? edit_admin_partner_category_path(@partner_category) : admin_partner_categories_path
    else
      flash[:error] = "Une erreur s'est produite lors de la mise à jour de la catégorie"
      render :edit
    end
  end

  def destroy
    begin
      @partner_category.destroy!
      flash[:notice] = "La catégorie a été supprimé avec succès"
    rescue ActiveRecord::DeleteRestrictionError
      flash[:error] = "Vous ne pouvez pas supprimer cette catégorie car elle a des données dépendantes"
    end
    redirect_to action: :index
  end

  private # =====================================================

  def partner_category_params
    params.require(:partner_category).permit(:title, :position, :enabled,
        seo_attributes: seo_attributes)
  end

  def get_partner_category
    @partner_category = PartnerCategory.from_param params[:id]
  end
end
