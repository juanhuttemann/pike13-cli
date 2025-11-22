# frozen_string_literal: true

module Pike13
  module CLI
    module Commands
      class Desk < Base
        class Service < Base
          # Override base_usage to match the actual subcommand registration
          def self.base_usage
            "desk services"
          end

          desc "list", "List all services"
          map "ls" => :list
          format_options
          def list
            handle_error do
              result = with_progress("Fetching services") do
                Pike13::Desk::Service.all
              end
              output(result)
            end
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
