# frozen_string_literal: true

module Pike13
  module CLI
    module Commands
      class Front < Base
        class EventOccurrence < Base
          # Override base_usage to match the actual subcommand registration
          def self.base_usage
            "front event_occurrences"
          end
          desc "list", "List event occurrences (client view)"
          format_options
          option :from, type: :string, desc: "Start date (YYYY-MM-DD)"
          option :to, type: :string, desc: "End date (YYYY-MM-DD)"
          option :ids, type: :string, desc: "Comma-separated event occurrence IDs"
          option :state, type: :string, desc: "Comma-separated states (active,canceled,reserved,deleted)"
          option :staff_member_ids, type: :string, desc: "Comma-separated staff member IDs"
          option :service_ids, type: :string, desc: "Comma-separated service IDs"
          option :event_ids, type: :string, desc: "Comma-separated event IDs"
          option :location_ids, type: :string, desc: "Comma-separated location IDs"
          def list
            validate_front_event_occurrence_date_formats
            handle_error do
              params = build_front_event_occurrence_params
              result = with_progress("Fetching event occurrences") do
                Pike13::Front::EventOccurrence.all(**params)
              end
              output(result)
            end
          end

          private

          def validate_front_event_occurrence_date_formats
            validate_date_format(options[:from], "from") if options[:from]
            validate_date_format(options[:to], "to") if options[:to]
          end

          def build_front_event_occurrence_params
            %i[from to ids state staff_member_ids service_ids event_ids location_ids]
              .each_with_object({}) { |key, params| params[key] = options[key] if options[key] }
          end
        end
      end
    end
  end
end
