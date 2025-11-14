# frozen_string_literal: true

module Pike13
  module CLI
    module Commands
      class Front < Base
        class Event < Base
          desc "list", "List events (client view)"
          format_options
          def list
            handle_error do
              result = with_progress("Fetching events") do
                Pike13::Front::Event.all
              end
              output(result)
            end
          end
        end
      end
    end
  end
end
