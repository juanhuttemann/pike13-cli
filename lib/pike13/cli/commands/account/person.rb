# frozen_string_literal: true

module Pike13
  module CLI
    module Commands
      class Account < Base
        class Person < Base
          desc "list", "List all people across businesses"
          format_options
          def list
            handle_error do
              result = with_progress("Fetching people") do
                Pike13::Account::Person.all
              end
              output(result)
            end
          end
        end
      end
    end
  end
end
