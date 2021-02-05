class AdminMailer < ApplicationMailer
  helper :formation, :schedule, :application

  def new_subscription
    @subscription = params[:subscription]
    @formation = @subscription.formation
    mail(to: Setting.admin_emails, subject: "[Site internet] Nouveau(x) participant(s) à la formation #{@formation.title}")
  end

  def newsletter_subscription
    @subscriber_email = params[:email]
    mail(to: Setting.admin_emails, subject: "[Site internet] Nouvelle inscription à la newsletter : #{@subscriber_email}")
  end
end
