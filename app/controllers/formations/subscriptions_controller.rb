# frozen_string_literal: true

class Formations::SubscriptionsController < Formations::BaseController

  before_action :get_subscription, only: [:show]

  def new
    @subscription = Subscription.new
    if session[:current_subscription_id].present?
      duplicate_participants
    else
      @subscription.participants.new
    end
  end

  def create
    @subscription = Subscription.new(subscription_params)
    respond_to do |format|
      if @subscription.save
        @subscription.touch(:cgu_accepted_at)
        AdminMailer.with(subscription: @subscription).new_subscription.deliver_later
        if save_subscription_is_checked?
          session[:current_subscription_id] = @subscription.id
        else
          session[:current_subscription_id] = nil
        end
        format.html { redirect_to formation_subscription_path(@formation, @subscription), notice: 'Votre inscription a bien été prise en compte' }
        format.json { render :show, status: :created, location: @subscription }
      else
        @subscription.participants.new if @subscription.participants.empty?
        format.html { render :new, alert: 'Il y a un soucis avec votre inscription'  }
        format.json { render json: @subscription.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
  end

  private

  def get_subscription
    @subscription = Subscription.find params[:id]
  end

  def subscription_params
    params.require(:subscription).permit(:formation_id, :save_subscription, :cgu_accepted,
      participants_attributes: [:organization, :firstname, :lastname, :email, :phone, :id, :_destroy])
  end

  def save_subscription_is_checked?
    ActiveModel::Type::Boolean.new.cast(subscription_params[:save_subscription]) == true
  end

  def duplicate_participants
    sub = Subscription.find(session[:current_subscription_id])
      participants = sub.participants.dup
      participants.map do |p|
        p.subscription_id = nil
        p.id = nil
      end
      @subscription.participants << participants
      @subscription.save_subscription = true
  end
end