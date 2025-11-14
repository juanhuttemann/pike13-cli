# frozen_string_literal: true

module Pike13
  module CLI
    module Commands
      class Front < Base
        class PersonVisit < Base
          desc "list PERSON_ID", "List visits for a person (client view)"
          format_options
          def list(person_id)
            handle_error do
              result = with_progress("Fetching person visits") do
                Pike13::Front::PersonVisit.all(person_id: person_id)
              end
              output(result)
            end
          end
        end
      end
    end
  end
end
