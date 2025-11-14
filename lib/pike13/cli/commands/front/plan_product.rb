# frozen_string_literal: true

module Pike13
  module CLI
    module Commands
      class Front < Base
        class PlanProduct < Base
          desc "list", "List all plan products"
          format_options
          def list
            handle_error do
              result = with_progress("Fetching plan products") do
                Pike13::Front::PlanProduct.all
              end
              output(result)
            end
          end

          desc "get ID", "Get a plan product by ID"
          format_options
          def get(id)
            handle_error do
              result = Pike13::Front::PlanProduct.find(id)
              output(result)
            end
          end
        end
      end
    end
  end
end
