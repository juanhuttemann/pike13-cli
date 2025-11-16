# frozen_string_literal: true

require_relative "../concerns/reporting_query"

module Pike13
  module CLI
    module Commands
      class Report < Base
        class PersonPlans < Base
          # Override base_usage to match the actual subcommand registration
          def self.base_usage
            "report person_plans"
          end
          include Concerns::ReportingQuery

          desc "query", "Query person plans report"
          def query
            handle_error do
              params = build_query_params
              params[:fields] ||= %w[person_plan_id person_id plan_name start_date is_available]
              result = with_progress("Fetching person plans report") do
                Pike13::Reporting::PersonPlans.query(**params)
              end
              output(result)
            end
          end
        end
      end
    end
  end
end
