# frozen_string_literal: true

module Pike13
  module CLI
    module Commands
      class Desk < Base
        class Event < Base
          desc "list", "List all events"
          map "ls" => :list
          format_options
          def list
            handle_error do
              result = with_progress("Fetching events") do
                Pike13::Desk::Event.all
              end
              output(result)
            end
          end

          desc "get ID", "Get an event by ID"
          format_options
          def get(id)
            handle_error do
              result = Pike13::Desk::Event.find(id)
              output(result)
            end
          end
        end
      end
    end
  end
end
