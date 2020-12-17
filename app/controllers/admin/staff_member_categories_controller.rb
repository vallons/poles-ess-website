# frozen_string_literal: true
class Admin::StaffMemberCategoriesController < Admin::BaseController

  before_action :get_staff_member_category, only: [:edit, :update, :destroy]

  def index
    @staff_member_categories = StaffMemberCategory.order(:position)
      # .page(params[:page]).per(20)
  end

  def new
    @staff_member_category = StaffMemberCategory.new
    @staff_member_category.build_seo
  end

  def create
    @staff_member_category = StaffMemberCategory.new(staff_member_category_params)
    if @staff_member_category.save
      flash[:notice] = "La catégorie a été créé avec succès"
      redirect_to params[:continue].present? ? edit_admin_staff_member_category_path(@staff_member_category) : admin_staff_member_categories_path
    else
      flash[:error] = "Une erreur s'est produite lors de la mise à jour de la catégorie"
      render :new
    end
  end

  def edit
  end

  def update
    if @staff_member_category.update(staff_member_category_params)
      flash[:notice] = "Catégorie mise à jour avec succès"
      redirect_to params[:continue].present? ? edit_admin_staff_member_category_path(@staff_member_category) : admin_staff_member_categories_path
    else
      flash[:error] = "Une erreur s'est produite lors de la mise à jour de la catégorie"
      render :edit
    end
  end

  def destroy
    begin
      @staff_member_category.destroy!
      flash[:notice] = "La catégorie a été supprimé avec succès"
    rescue ActiveRecord::DeleteRestrictionError
      flash[:error] = "Vous ne pouvez pas supprimer cette catégorie car elle a des données dépendantes"
    end
    redirect_to action: :index
  end

  private # =====================================================

  def staff_member_category_params
    params.require(:staff_member_category).permit(:title, :position, :enabled,
        seo_attributes: seo_attributes)
  end

  def get_staff_member_category
    @staff_member_category = StaffMemberCategory.from_param params[:id]
  end
end
