# frozen_string_literal: true

module Pike13
  module CLI
    module Commands
      class Desk < Base
        class EventOccurrenceWaitlistEntry < Base
          desc "list EVENT_OCCURRENCE_ID", "List waitlist entries for an event occurrence"
          format_options
          def list(event_occurrence_id)
            handle_error do
              result = with_progress("Fetching event occurrence waitlist entries") do
                Pike13::Desk::EventOccurrenceWaitlistEntry.all(event_occurrence_id: event_occurrence_id)
              end
              output(result)
            end
          end
        end
      end
    end
  end
end
