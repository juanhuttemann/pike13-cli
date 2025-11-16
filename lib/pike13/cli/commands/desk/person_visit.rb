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
          def list(person_id)
            handle_error do
              result = with_progress("Fetching person visits") do
                Pike13::Desk::PersonVisit.all(person_id: person_id)
              end
              output(result)
            end
          end
        end
      end
    end
  end
end
