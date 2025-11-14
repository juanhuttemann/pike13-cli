# frozen_string_literal: true

module Pike13
  module CLI
    module Commands
      class Front < Base
        class PersonPlan < Base
          desc "list PERSON_ID", "List plans for a person (client view)"
          format_options
          def list(person_id)
            handle_error do
              result = with_progress("Fetching person plans") do
                Pike13::Front::PersonPlan.all(person_id: person_id)
              end
              output(result)
            end
          end
        end
      end
    end
  end
end
