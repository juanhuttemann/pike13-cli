# frozen_string_literal: true

module Pike13
  module CLI
    module Commands
      class Desk < Base
        class PlanProduct < Base
          desc "list", "List all plan products"
          format_options
          def list
            handle_error do
              result = with_progress("Fetching plan products") do
                Pike13::Desk::PlanProduct.all
              end
              output(result)
            end
          end

          desc "get ID", "Get a plan product by ID"
          format_options
          def get(id)
            handle_error do
              result = Pike13::Desk::PlanProduct.find(id)
              output(result)
            end
          end
        end
      end
    end
  end
end
