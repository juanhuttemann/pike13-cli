# frozen_string_literal: true

require_relative "../concerns/reporting_query"

module Pike13
  module CLI
    module Commands
      class Report < Base
        class MonthlyBusinessMetrics < Base
          include Concerns::ReportingQuery

          desc "query", "Query monthly business metrics report"
          def query
            handle_error do
              params = build_query_params
              result = with_progress("Fetching monthly business metrics report") do
                Pike13::Reporting::MonthlyBusinessMetrics.query(**params)
              end
              output(result)
            end
          end
        end
      end
    end
  end
end
