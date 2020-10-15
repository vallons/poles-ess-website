class AdminMailer < ApplicationMailer
  default to: Setting.admin_emails

  helper :formation, :schedule, :application

  def new_subscription
    @subscription = params[:subscription]
    @formation = @subscription.formation
    mail(subject: "[Site internet] Nouveau(x) participant(s) à la formation #{@formation.title}")
  end

end
