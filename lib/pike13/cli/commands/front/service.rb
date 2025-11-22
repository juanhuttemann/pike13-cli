# frozen_string_literal: true

module Pike13
  module CLI
    module Commands
      class Front < Base
        class Service < Base
          # Override base_usage to match the actual subcommand registration
          def self.base_usage
            "front services"
          end

          desc "list", "List services (client view)"
          format_options
          def list
            handle_error do
              result = with_progress("Fetching services") do
                Pike13::Front::Service.all
              end
              output(result)
            end
          end
        end
      end
    end
  end
end
