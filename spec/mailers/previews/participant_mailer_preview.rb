# Preview all emails at http://localhost:3000/rails/mailers/participant_mailer
class ParticipantMailerPreview < ActionMailer::Preview

  def new_subscription
    ParticipantMailer.with(participant: Participant.last).new_subscription
  end

end