# frozen_string_literal: true

module Pike13
  module CLI
    module Commands
      class Desk < Base
        class Plans < Base
          desc "list", "List all plans"
          format_options
          def list
            handle_error { output(Pike13::Desk::Plan.all) }
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
