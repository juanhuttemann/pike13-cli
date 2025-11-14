# frozen_string_literal: true

module Pike13
  module CLI
    module Commands
      class Desk < Base
        class PersonWaiver < Base
          desc "list PERSON_ID", "List waivers for a person"
          map "ls" => :list
          format_options
          def list(person_id)
            handle_error do
              result = with_progress("Fetching person waivers") do
                Pike13::Desk::PersonWaiver.all(person_id: person_id)
              end
              output(result)
            end
          end
        end
      end
    end
  end
end
