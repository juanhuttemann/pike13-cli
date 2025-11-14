# frozen_string_literal: true

module Pike13
  module CLI
    module Commands
      class Front < Base
        class EventOccurrenceNote < Base
          desc "list EVENT_OCCURRENCE_ID", "List notes for an event occurrence"
          format_options
          def list(event_occurrence_id)
            handle_error do
              result = with_progress("Fetching event occurrence notes") do
                Pike13::Front::EventOccurrenceNote.all(event_occurrence_id: event_occurrence_id)
              end
              output(result)
            end
          end

          desc "get EVENT_OCCURRENCE_ID ID", "Get a specific note for an event occurrence"
          format_options
          def get(event_occurrence_id, id)
            handle_error do
              result = Pike13::Front::EventOccurrenceNote.find(event_occurrence_id: event_occurrence_id, id: id)
              output(result)
            end
          end
        end
      end
    end
  end
end
