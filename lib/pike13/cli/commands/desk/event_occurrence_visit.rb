# frozen_string_literal: true

module Pike13
  module CLI
    module Commands
      class Desk < Base
        class EventOccurrenceVisit < Base
          # Override base_usage to match the actual subcommand registration
          def self.base_usage
            "desk event_occurrence_visits"
          end
          desc "list EVENT_OCCURRENCE_ID", "List visits for an event occurrence"
          format_options
          def list(event_occurrence_id)
            handle_error do
              result = with_progress("Fetching event occurrence visits") do
                Pike13::Desk::EventOccurrenceVisit.all(event_occurrence_id: event_occurrence_id)
              end
              output(result)
            end
          end
        end
      end
    end
  end
end
