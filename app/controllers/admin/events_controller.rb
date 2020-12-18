class Admin::EventsController < Admin::BaseController
  include DestroyableUpload

  before_action :get_event, except: %i[index new create]

  def index
    @events = Event
      .page(params[:page]).per(25)
  end

  def new
    @event = Event.new
    @event.build_schedule
  end

  def create
    @event = Event.new(event_params)
    if @event.save
      flash[:notice] = "L'événement a été créé avec succès"
      redirect_to params[:continue].present? ? edit_admin_event_path(@event) : admin_events_path
    else
      @event.build_schedule if @event.schedule.nil?
      flash[:error] = "Une erreur s'est produite lors de la mise à jour de l'événement"
      render :new
    end
  end

  def edit
  end

  def update
    # weird bug preventing schedules modifications to be saved otherwise
    @event.assign_attributes(event_params)
    schedule_params = event_params[:schedule_attributes]
    if schedule_params.present? && schedule_params.fetch(:id).present?
      schedule = @event.schedule
      schedule.assign_attributes(schedule_params.except(:_destroy))
      schedule.save
    end

    if @event.save
      flash[:notice] = "L'événement a été mis à jour avec succès"
      redirect_to params[:continue].present? ? edit_admin_event_path(@event) : admin_events_path
    else
      flash[:error] = "Une erreur s'est produite lors de la mise à jour de l'événement"
      render :edit
    end
  end

  def destroy
    begin
      @event.destroy!
      flash[:notice] = "L'événement a été supprimé avec succès"
    rescue ActiveRecord::DeleteRestrictionError
      flash[:error] = "Vous ne pouvez pas supprimer cette event car elle a des données dépendantes"
    end
    redirect_to action: :index
  end

  private # =====================================================

  def event_params
    params.require(:event).permit(:title, :link, :enabled,
      schedule_attributes: [:date, :start_at, :end_at, :id, :_destroy]
  )
  end

  def get_event
    @event = Event.from_param params[:id]
  end
end
