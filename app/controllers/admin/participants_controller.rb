class Admin::ParticipantsController < Admin::BaseController
  before_action :get_participant, except: [:index, :new, :create]

  def index
    @participants = Participant
      .apply_filters(params)
      .apply_sorts(params)
      # .page(params[:page]).per(20)
    @formation = Formation.find(params[:by_formation]) if params[:by_formation].present?
  end

  def new
    @participant = Participant.new
  end

  def create
    @participant = Participant.new(participant_params)
    respond_to do |format|
      if @participant.save
        format.html { redirect_to formation_participant_path(@formation, @participant), notice: 'Supscription was successfully created.' }
        format.json { render :show, status: :created, location: @participant }
      else
        format.html { render :new }
        format.json { render json: @participant.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
  end

  def confirm_participation
    @participant.participation_confirmed!
    flash[:notice] = "L'inscription a bien été confirmée"
    redirect_back fallback_location: admin_participants_path
  end

  def place_in_waiting_line
    @participant.in_waiting_line!
    flash[:notice] = "Le participant a bien été placé en fil d'attente"
    redirect_back fallback_location: admin_participants_path
  end

  def destroy
    @participant.destroy
    flash[:notice] = "L'inscription a été annulée avec succès"
    redirect_back fallback_location: admin_participants_path
  end

  private

  def get_participant
    @participant = Participant.find params[:id]
  end

  def participant_params
    params.require(:participant).permit(:organization, :firstname, :lastname, :email, :phone, :id, :_destroy)
  end

end