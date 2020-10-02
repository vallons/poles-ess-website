module ParticipantHelper

# Etat -----------------------------------------------

  def participant_status_title(status)
    I18n.t(status, scope: %i(participant status title))
  end

  def participant_status_style(status)
    I18n.t(status, scope: %i(participant status style))
  end

  def participant_status_options(status = Participant.statuses.keys)
    status.map do |state|
      [participant_status_title(state), state.to_s]
    end
  end

  def participant_organization(participant)
    return participant.organization if !participant.organization.blank?
    "-"
  end

  def participation_confirmable?(participant)
    participant.in_waiting_line?
  end
end