# frozen_string_literal: true

module Pike13
  module CLI
    module Commands
      class Desk < Base
        class Location < Base
          # Override base_usage to match the actual subcommand registration
          def self.base_usage
            "desk locations"
          end

          desc "list", "List all locations"
          map "ls" => :list
          format_options
          def list
            handle_error do
              result = with_progress("Fetching locations") do
                Pike13::Desk::Location.all
              end
              output(result)
            end
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
