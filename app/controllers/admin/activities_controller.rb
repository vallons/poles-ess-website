class Admin::ActivitiesController < Admin::BaseController

  before_action :get_activity, only: [:edit, :update, :destroy, :destroy_image]

  def index
    @activities = Activity
      .apply_filters(params)
      .apply_sorts(params)
      # .page(params[:page]).per(20)
  end

  def new
    @activity = Activity.new
    @activity.build_seo
  end

  def create
    @activity = Activity.new(activity_params)
    if @activity.save
      flash[:notice] = "L'action a été créé avec succès"
      redirect_to params[:continue].present? ? edit_admin_activity_path(@activity) : admin_activities_path
    else
      flash[:error] = "Une erreur s'est produite lors de la mise à jour de l'action"
      render :new
    end
  end

  def edit
  end

  def update
    if @activity.update_attributes(activity_params)
      flash[:notice] = "Action miss à jour avec succès"
      redirect_to params[:continue].present? ? edit_admin_activity_path(@activity) : admin_activities_path
    else
      flash[:error] = "Une erreur s'est produite lors de la mise à jour de l'action"
      render :edit
    end
  end

  def destroy
    begin
      @activity.destroy!
      flash[:notice] = "L'action a été supprimée avec succès"
    rescue ActiveRecord::DeleteRestrictionError
      flash[:error] = "Vous ne pouvez pas supprimer cette action car elle a des données dépendantes"
    end
    redirect_to admin_activities_path
  end

  def destroy_image
    @activity.main_image.purge
    flash[:notice] = "L'image a bien été supprimée"

    render :edit
  end


 
  private # =====================================================

  def activity_params
    params.require(:activity).permit(:title, :description, :image,
      theme_ids: [], seo_attributes: seo_attributes
)
  end

  def get_activity
    @activity = Activity.from_param params[:id]
  end
 
end
