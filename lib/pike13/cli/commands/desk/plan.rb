# frozen_string_literal: true

module Pike13
  module CLI
    module Commands
      class Desk < Base
        class Plan < Base
          desc "list", "List all plans"
          map "ls" => :list
          format_options
          def list
            handle_error do
              result = with_progress("Fetching plans") do
                Pike13::Desk::Plan.all
              end
              output(result)
            end
          end

          desc "get ID", "Get a plan by ID"
          format_options
          def get(id)
            handle_error { output(Pike13::Desk::Plan.find(id)) }
          end
        end
      end
    end
  end
end
