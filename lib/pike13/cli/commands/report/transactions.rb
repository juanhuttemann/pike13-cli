# frozen_string_literal: true

require_relative "../concerns/reporting_query"

module Pike13
  module CLI
    module Commands
      class Report < Base
        class Transactions < Base
          include Concerns::ReportingQuery

          desc "query", "Query transactions report"
          def query
            handle_error do
              params = build_query_params
              params[:fields] ||= %w[transaction_id completed_at person_full_name transaction_amount payment_method]
              result = with_progress("Fetching transactions report") do
                Pike13::Reporting::Transactions.query(**params)
              end
              output(result)
            end
          end
        end
      end
    end
  end
end
