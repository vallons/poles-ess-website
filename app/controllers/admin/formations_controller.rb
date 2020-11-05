class Admin::FormationsController < Admin::BaseController
  include DestroyableUpload

  before_action :get_formation, only: [:edit, :update, :destroy]

  def index
    @pagy, @formations = pagy(
       @formations = Formation
      .apply_filters(params)
      .apply_sorts(params), items: 12
    )
  end

  def new
    @formation = Formation.default
  end

  def create
    @formation = Formation.new(formation_params)
    if @formation.save
      flash[:notice] = "La formation a été créée avec succès"
      redirect_to params[:continue].present? ? edit_admin_formation_path(@formation) : admin_formations_path
    else
      @formation.schedules.new  if @formation.schedules.empty?
      flash[:error] = "Une erreur s'est produite lors de la mise à jour de la formation"
      render :new
    end
  end

  def edit
  end

  def update
    if @formation.update(formation_params)
      flash[:notice] = "Formation mis à jour avec succès"
      redirect_to params[:continue].present? ? edit_admin_formation_path(@formation) : admin_formations_path
    else
      flash[:error] = "Une erreur s'est produite lors de la mise à jour de la formation"
      render :edit
    end
  end

  def destroy
    begin
      @formation.destroy!
      flash[:notice] = "La formation a été supprimée avec succès"
    rescue ActiveRecord::DeleteRestrictionError
      flash[:error] = "Vous ne pouvez pas supprimer cette formation car elle a des données dépendantes"
    end
    redirect_to action: :index
  end

  private # =====================================================

  def formation_params
    params.require(:formation).permit(:title, :description, :formation_category_id,
      :speaker, :tickets_count, :cost, :address ,:zipcode, :city, :id, :image,
      schedules_attributes: [:date, :start_at, :end_at, :id, :_destroy],
      seo_attributes: seo_attributes
)
  end

  def get_formation
    @formation = Formation.from_param params[:id]
  end
end
