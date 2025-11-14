# frozen_string_literal: true

module Pike13
  module CLI
    module Commands
      class Desk < Base
        class SalesTax < Base
          desc "list", "List all sales taxes"
          map "ls" => :list
          format_options
          def list
            handle_error do
              result = with_progress("Fetching sales taxes") do
                Pike13::Desk::SalesTax.all
              end
              output(result)
            end
          end

          desc "get ID", "Get a sales tax by ID"
          format_options
          def get(id)
            handle_error do
              result = Pike13::Desk::SalesTax.find(id)
              output(result)
            end
          end
        end
      end
    end
  end
end
