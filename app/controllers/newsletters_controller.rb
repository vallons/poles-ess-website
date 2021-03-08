class NewslettersController < ApplicationController
  def create
    api_instance = SibApiV3Sdk::ContactsApi.new
    contact_params = {
      email: params[:email],
      listIds: [ENV['SENDINBLUE_NEWSLETTER_ID'].to_i],
      updateEnabled: true
    }

    begin
      # api_instance.create_contact(SibApiV3Sdk::CreateContact.new(contact_params))
      # AdminMailer.with(email: params[:email]).newsletter_subscription.deliver_now
      flash[:notice] = "Votre inscription à la newsletter a bien été prise en compte"
    rescue SibApiV3Sdk::ApiError => e
      flash[:warning] = "Une erreur s’est produite, merci de réessayer ultérieurement"
    end

    redirect_back fallback_location: root_path
  end
end