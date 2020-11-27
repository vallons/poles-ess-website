class Admin::MainPagesController < Admin::BaseController
  include DestroyableUpload

  before_action :get_main_page, except: %i[index new create]

  def index
    @main_pages = MainPage.includes(:seo).order(:position)
      .page(params[:page]).per(20)
  end

  def new
    @main_page = MainPage.new
    @main_page.build_seo
    @main_page.resources.new
  end

  def create
    @main_page = MainPage.new(main_page_params)
    if @main_page.save
      flash[:notice] = "La page a été créé avec succès"
      redirect_to params[:continue].present? ? edit_admin_main_page_path(@main_page) : admin_main_pages_path
    else
      @main_page.resources.new if @main_page.resources.empty?
      flash[:error] = "Une erreur s'est produite lors de la mise à jour de la page"
      render :new
    end
  end

  def edit
    @main_page.resources.new if @main_page.resources.empty?
  end

  def update
    if @main_page.update_attributes(main_page_params)
      flash[:notice] = "Page mise à jour avec succès"
      redirect_to params[:continue].present? ? edit_admin_main_page_path(@main_page) : admin_main_pages_path
    else
      flash[:error] = "Une erreur s'est produite lors de la mise à jour de la page"
      render :edit
    end
  end

  def edit_configuration
    2.times { @main_page.menu_blocks.new } if @main_page.menu_blocks.empty?
  end

  def update_configuration
    if @main_page.update_attributes(main_page_params)
      flash[:notice] = "Page mise à jour avec succès"
      redirect_to params[:continue].present? ? edit_configuration_admin_main_page_path(@main_page) : admin_main_pages_path
    else
      flash[:error] = "Une erreur s'est produite lors de la mise à jour de la page"
      render :edit_configuration
    end
  end
  def destroy
    begin
      @main_page.destroy!
      flash[:notice] = "La page a été supprimée avec succès"
    rescue ActiveRecord::DeleteRestrictionError
      flash[:error] = "Vous ne pouvez pas supprimer cette page car il a des données dépendantes"
    end
    redirect_to action: :index
  end

  private # =====================================================

  def main_page_params
    params.require(:main_page).permit(:title, :baseline, :description, :image, :position, :enabled,
        seo_attributes: seo_attributes, resources_attributes: resources_attributes
)
  end

  def get_main_page
    @main_page = MainPage.from_param params[:id]
  end
 
end
