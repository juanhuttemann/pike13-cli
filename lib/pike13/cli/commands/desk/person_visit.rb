# frozen_string_literal: true

module Pike13
  module CLI
    module Commands
      class Desk < Base
        class PersonVisit < Base
          # Override base_usage to match the actual subcommand registration
          def self.base_usage
            "desk person_visits"
          end
          desc "list PERSON_ID", "List visits for a person"
          map "ls" => :list
          format_options
          option :from, type: :string, desc: "Start date for visit time range (YYYY-MM-DD or timestamp)"
          option :to, type: :string, desc: "End date for visit time range (YYYY-MM-DD or timestamp)"
          option :event_occurrence_id, type: :numeric, desc: "Scope to a specific event occurrence"
          def list(person_id)
            validate_date_format(options[:from], "from") if options[:from]
            validate_date_format(options[:to], "to") if options[:to]

            handle_error do
              params = {}
              params[:from] = options[:from] if options[:from]
              params[:to] = options[:to] if options[:to]
              params[:event_occurrence_id] = options[:event_occurrence_id] if options[:event_occurrence_id]

              result = with_progress("Fetching visits for person #{person_id}") do
                Pike13::Desk::PersonVisit.all(person_id: person_id, **params)
              end
              output(result)
            end
          end
        end
      end
    end
  end
end
