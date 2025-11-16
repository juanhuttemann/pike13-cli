# frozen_string_literal: true

module Pike13
  module CLI
    module Commands
      class Desk < Base
        class SalesTax < Base
          # Override base_usage to match the actual subcommand registration
          def self.base_usage
            "desk sales_taxes"
          end
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
