class ParticipantMailer < ApplicationMailer

  helper :formation, :schedule, :application

  def new_subscription
    @participant = params[:participant]
    @formation = @participant.formation
    @template = EmailTemplate.where(mailer: "ParticipantMailer", mail_name: "new_subscription").first
    mail(to: @participant.email, subject: "Votre inscription à la formation #{@formation.title}")
  end

end