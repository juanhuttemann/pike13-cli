# frozen_string_literal: true

module Pike13
  module CLI
    module Commands
      class Desk < Base
        class Invoice < Base
          # Override base_usage to match the actual subcommand registration
          def self.base_usage
            "desk invoices"
          end

          desc "list", "List all invoices"
          map "ls" => :list
          format_options
          def list
            handle_error do
              result = with_progress("Fetching invoices") do
                Pike13::Desk::Invoice.all
              end
              output(result)
            end
          end

          desc "get ID", "Get a invoice by ID"
          format_options
          def get(id)
            handle_error { output(Pike13::Desk::Invoice.find(id)) }
          end
        end
      end
    end
  end
end
