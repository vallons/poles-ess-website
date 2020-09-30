class Admin::FormationsController < Admin::BaseController

  include DestroyableUpload

  before_action :get_formation, only: [:edit, :update, :destroy]

  def index
    @formations = Formation
      .apply_filters(params)
      .apply_sorts(params)
      # .page(params[:page]).per(20)
  end

  def new
    @form = FormationForm.new(Formation.new)
    @form.prepopulate!
  end

  def create
    @form = FormationForm.new(Formation.new)
    if @form.validate(formation_params)
      deal_with_reform_activestorage_incompatibility
      @form.save
      flash[:notice] = "La formation a été créé avec succès"
      redirect_to params[:continue].present? ? edit_admin_formation_path(@form.model) : admin_formations_path
    else
      @form.prepopulate!
      flash[:error] = "Une erreur s'est produite lors de la mise à jour de la formation"
      render :new
    end
  end

  def edit
    @form = FormationForm.new(@formation)
    @form.prepopulate!
  end

  def update
    @form = FormationForm.new(@formation)
    if @form.validate(formation_params)
      deal_with_reform_activestorage_incompatibility
      @form.save
      flash[:notice] = "Formation mise à jour avec succès"
      redirect_to params[:continue].present? ? edit_admin_formation_path(@formation) : admin_formations_path
    else
      @form.prepopulate!
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
    params.require(:formation).permit(:title, :description, :formation_category_id, :id,
      :speaker, :tickets_count, :cost, :address ,:zipcode, :city, :id, :image,
      schedules_attributes: [:date, :start_at, :end_at, :id],
      seo_attributes: seo_attributes
)
  end

  def get_formation
    @formation = Formation.from_param params[:id]
  end

  # cf https://gitter.im/trailblazer/chat?at=5e9d8c26c7dcfc14e2d42b9c
  def deal_with_reform_activestorage_incompatibility
    unless (@form.image.is_a?(ActionDispatch::Http::UploadedFile) || @form.image.is_a?(Rack::Test::UploadedFile))
      @form.image = nil
    end
  end
 
end
