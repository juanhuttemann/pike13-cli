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
              params[:fields] ||= %w[month_start_date net_paid_amount member_count new_client_count]
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
