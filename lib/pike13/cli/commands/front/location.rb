# frozen_string_literal: true

module Pike13
  module CLI
    module Commands
      class Front < Base
        class Location < Base
          desc "list", "List locations (client view)"
          format_options
          def list
            handle_error do
              result = with_progress("Fetching locations") do
                Pike13::Front::Location.all
              end
              output(result)
            end
          end
        end
      end
    end
  end
end
