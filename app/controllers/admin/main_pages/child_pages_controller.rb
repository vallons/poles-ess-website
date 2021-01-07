# frozen_string_literal: true

class Admin::MainPages::ChildPagesController < Admin::MainPages::BaseController
  before_action :find_child_page, except: %i[index new create]

  def index
    @child_pages = child_pages_scope.includes(:seo)
      .apply_filters(params)
      .apply_sorts(params)
      .page(params[:page]).per(20)
  end

  def new
    @child_page = child_pages_scope.new
    @child_page.build_seo
    @child_page.resources.new
  end

  def create
    @child_page = child_pages_scope.new(child_page_params)
    if @child_page.save
      flash[:notice] = 'La page a été créée avec succès'
      redirect_to params[:continue].present? ? edit_admin_main_page_child_page_path(@main_page, @child_page) : admin_main_page_child_pages_path(@main_page)
    else
      flash[:error] = "Une erreur s'est produite lors de la création de la page"
      render :new
    end
  end

  def edit
    @child_page.resources.new if @child_page.resources.empty?
  end

  def update
    if @child_page.update(child_page_params)
      flash[:notice] = 'La page a été mise à jour avec succès'
      redirect_after_update_main_page(@child_page)
    else
      flash[:error] = "Une erreur s'est produite lors de la mise à jour de la page"
      render :edit
    end
  end

  def position
    if params[:position].present?
      @child_page.insert_at params[:position].to_i
      flash[:notice] = 'Les pages ont été réordonnées avec succès'
    end
    redirect_to admin_main_page_child_pages_path(@main_page)
  end

  def destroy
    @child_page.destroy
    flash[:notice] = 'La page a été supprimée avec succès'
    redirect_to admin_main_page_child_pages_path(@main_page)
  end

  private

  def child_pages_scope
    @main_page.child_pages
  end

  def find_child_page
    @child_page = child_pages_scope.from_param params[:id]
  end

  # strong parameters
  def child_page_params
    params.require(:child_page).permit(
      :title, :description, :enabled, :parent_page_id, :position,
      seo_attributes: seo_attributes,
      resources_attributes: resources_attributes
    )
  end
end
