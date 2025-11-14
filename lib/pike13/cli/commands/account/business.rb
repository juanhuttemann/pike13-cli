# frozen_string_literal: true

module Pike13
  module CLI
    module Commands
      class Account < Base
        class Business < Base
          desc "list", "List all businesses for the account"
          format_options
          def list
            handle_error do
              result = with_progress("Fetching businesses") do
                Pike13::Account::Business.all
              end
              output(result)
            end
          end
        end
      end
    end
  end
end
