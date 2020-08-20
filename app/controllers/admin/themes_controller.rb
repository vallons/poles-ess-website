class Admin::ThemesController < Admin::BaseController

  before_action :find_theme, only: [:edit, :update, :destroy, :destroy_image]

  def index
    @themes = Theme
      .order(created_at: :desc)
      # .page(params[:page]).per(20)
  end

  def new
    @theme = Theme.new
  end

  def create
    @theme = Theme.new(theme_params)
    if @theme.save
      flash[:notice] = "Le thème a été créé avec succès"
      redirect_to action: :index
    else
      flash[:error] = "Une erreur s'est produite lors de la mise à jour du thème"
      render :new
    end
  end

  def edit
  end

  def update
    if @theme.update_attributes(theme_params)
      flash[:notice] = "Thème mis à jour avec succès"
      redirect_to action: :index
    else
      flash[:error] = "Une erreur s'est produite lors de la mise à jour du thème"
      render :edit
    end
  end

  def destroy
    begin
      @theme.destroy!
      flash[:notice] = "Le thème a été supprimé avec succès"
    rescue ActiveRecord::DeleteRestrictionError
      flash[:error] = "Vous ne pouvez pas supprimer ce thème car il a des données dépendantes"
    end
    redirect_to action: :index
  end

  def destroy_image
    @theme.main_image.purge
    flash[:notice] = "L'image a bien été supprimée"

    render :edit
  end


 
  private # =====================================================

  def theme_params
    params.require(:theme).permit(:title, :description, :baseline, :main_image)
  end

  def find_theme
    @theme = Theme.find(params[:id])
  end
 
end