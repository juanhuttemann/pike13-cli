# frozen_string_literal: true

module Pike13
  module CLI
    module Commands
      class Desk < Base
        class Services < Base
          desc "list", "List all services"
          format_options
          def list
            handle_error { output(Pike13::Desk::Service.all) }
          end

          desc "get ID", "Get a service by ID"
          format_options
          def get(id)
            handle_error { output(Pike13::Desk::Service.find(id)) }
          end
        end
      end
    end
  end
end
