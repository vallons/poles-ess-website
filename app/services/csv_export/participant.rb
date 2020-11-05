module CsvExport
  class Participant < Base
    extend ParticipantHelper 

    private

    def headers
      %w["Formation" "DateFormation" "NbPlace" "DateInscription" "Structure" "Prénom" "Nom" "Email" "Téléphone" "Participation"]
    end

    def attributes(participant)
      formation = participant.formation
      return [ formation.title,
        formation.schedules.map{ |s| s.time_range.begin.strftime("%d/%m/%Y") }.join(" - "),
        formation.tickets_count,
        I18n.l(participant.created_at),
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
