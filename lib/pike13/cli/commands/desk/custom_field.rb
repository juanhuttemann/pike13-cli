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

          desc "get ID", "Get a custom field by ID"
          format_options
          def get(id)
            handle_error do
              result = Pike13::Desk::CustomField.find(id)
              output(result)
            end
          end
        end
      end
    end
  end
end
