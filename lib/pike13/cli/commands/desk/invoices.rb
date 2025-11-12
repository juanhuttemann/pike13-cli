# frozen_string_literal: true

module Pike13
  module CLI
    module Commands
      class Desk < Base
        class Invoices < Base
          desc "list", "List all invoices"
          format_options
          def list
            handle_error { output(Pike13::Desk::Invoice.all) }
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
