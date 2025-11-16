# frozen_string_literal: true

module Pike13
  module CLI
    module Commands
      class Front < Base
        class EventOccurrenceWaitlistEligibility < Base
          # Override base_usage to match the actual subcommand registration
          def self.base_usage
            "front event_occurrence_waitlist_eligibilities"
          end

          desc "list EVENT_OCCURRENCE_ID", "List waitlist eligibility for an event occurrence"
          format_options
          def list(event_occurrence_id)
            handle_error do
              result = with_progress("Fetching waitlist eligibility") do
                Pike13::Front::EventOccurrenceWaitlistEligibility.all(event_occurrence_id: event_occurrence_id)
              end
              output(result)
            end
          end
        end
      end
    end
  end
end
