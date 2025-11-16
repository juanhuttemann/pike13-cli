# frozen_string_literal: true

module Pike13
  module CLI
    module Commands
      class Desk < Base
        class PersonPlan < Base
          # Override base_usage to match the actual subcommand registration
          def self.base_usage
            "desk person_plans"
          end
          desc "list PERSON_ID", "List plans for a person"
          map "ls" => :list
          format_options
          def list(person_id)
            handle_error do
              result = with_progress("Fetching person plans") do
                Pike13::Desk::PersonPlan.all(person_id: person_id)
              end
              output(result)
            end
          end
        end
      end
    end
  end
end
