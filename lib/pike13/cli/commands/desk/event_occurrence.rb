# frozen_string_literal: true

module Pike13
  module CLI
    module Commands
      class Desk < Base
        class EventOccurrence < Base
          # Override base_usage to match the actual subcommand registration
          def self.base_usage
            "desk event_occurrences"
          end
          desc "list", "List event occurrences"
          map "ls" => :list
          format_options
          option :from, type: :string, desc: "Start date (YYYY-MM-DD)"
          option :to, type: :string, desc: "End date (YYYY-MM-DD)"
          option :ids, type: :string, desc: "Comma-separated event occurrence IDs"
          option :state, type: :string, desc: "Comma-separated states (active,canceled,reserved,deleted)"
          option :staff_member_ids, type: :string, desc: "Comma-separated staff member IDs"
          option :service_ids, type: :string, desc: "Comma-separated service IDs"
          option :event_ids, type: :string, desc: "Comma-separated event IDs"
          option :location_ids, type: :string, desc: "Comma-separated location IDs"
          option :group_by, type: :string, desc: "Group results by (day,hour)"
          def list
            validate_event_occurrence_date_formats
            handle_error do
              params = build_event_occurrence_params
              result = with_progress("Fetching event occurrences") do
                Pike13::Desk::EventOccurrence.all(**params)
              end
              output(result)
            end
          end

          desc "get ID", "Get an event occurrence by ID"
          format_options
          def get(id)
            handle_error do
              result = Pike13::Desk::EventOccurrence.find(id)
              output(result)
            end
          end

          desc "summary", "Get event occurrence summary"
          format_options
          def summary
            handle_error do
              result = Pike13::Desk::EventOccurrence.summary
              output(result)
            end
          end

          desc "eligibilities ID", "Get enrollment eligibilities for an event occurrence"
          format_options
          option :person_ids, type: :string, desc: "Comma-separated person IDs"
          def eligibilities(id)
            handle_error do
              params = { id: id }
              params[:person_ids] = options[:person_ids] if options[:person_ids]

              result = Pike13::Desk::EventOccurrence.enrollment_eligibilities(**params)
              output(result)
            end
          end

          private

          def validate_event_occurrence_date_formats
            validate_date_format(options[:from], "from") if options[:from]
            validate_date_format(options[:to], "to") if options[:to]
          end

          def build_event_occurrence_params
            %i[from to ids state staff_member_ids service_ids event_ids location_ids group_by]
              .each_with_object({}) { |key, params| params[key] = options[key] if options[key] }
          end
        end
      end
    end
  end
end
