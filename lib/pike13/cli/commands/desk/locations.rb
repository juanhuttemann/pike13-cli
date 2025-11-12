# frozen_string_literal: true

module Pike13
  module CLI
    module Commands
      class Desk < Base
        class Locations < Base
          desc "list", "List all locations"
          format_options
          def list
            handle_error { output(Pike13::Desk::Location.all) }
          end

          desc "get ID", "Get a location by ID"
          format_options
          def get(id)
            handle_error { output(Pike13::Desk::Location.find(id)) }
          end
        end
      end
    end
  end
end
