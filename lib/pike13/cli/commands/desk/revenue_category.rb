# frozen_string_literal: true

module Pike13
  module CLI
    module Commands
      class Desk < Base
        class RevenueCategory < Base
          # Override base_usage to match the actual subcommand registration
          def self.base_usage
            "desk revenue_categories"
          end
          desc "list", "List all revenue categories"
          map "ls" => :list
          format_options
          def list
            handle_error do
              result = with_progress("Fetching revenue categories") do
                Pike13::Desk::RevenueCategory.all
              end
              output(result)
            end
          end

          desc "get ID", "Get a revenue category by ID"
          format_options
          def get(id)
            handle_error do
              result = Pike13::Desk::RevenueCategory.find(id)
              output(result)
            end
          end
        end
      end
    end
  end
end
