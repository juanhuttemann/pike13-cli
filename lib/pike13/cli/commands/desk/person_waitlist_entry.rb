# frozen_string_literal: true

module Pike13
  module CLI
    module Commands
      class Desk < Base
        class PersonWaitlistEntry < Base
          desc "list PERSON_ID", "List waitlist entries for a person"
          map "ls" => :list
          format_options
          def list(person_id)
            handle_error do
              result = with_progress("Fetching person waitlist entries") do
                Pike13::Desk::PersonWaitlistEntry.all(person_id: person_id)
              end
              output(result)
            end
          end
        end
      end
    end
  end
end
