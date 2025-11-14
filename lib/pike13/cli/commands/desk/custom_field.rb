# frozen_string_literal: true

module Pike13
  module CLI
    module Commands
      class Desk < Base
        class CustomField < Base
          desc "list", "List all custom fields"
          map "ls" => :list
          format_options
          def list
            handle_error do
              result = with_progress("Fetching custom fields") do
                Pike13::Desk::CustomField.all
              end
              output(result)
            end
          end
        end
      end
    end
  end
end
