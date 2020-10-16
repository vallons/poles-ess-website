module CsvExport
  class Participant < Base
    extend ParticipantHelper 

    private

    def headers
      %w["DateInscription" "Structure" "Prénom" "Nom" "Email" "Téléphone" "Participation"]
    end

    def attributes(participant)
      [ I18n.l(participant.created_at),
        participant.organization,
        participant.firstname,
        participant.lastname,
        participant.email,
        participant.phone,
        I18n.t(participant.status, scope: %i(participant status title))
      ]
    end
  end
end