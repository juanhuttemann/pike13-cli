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
              params[:fields] ||= %w[transaction_id transaction_date payment_method transaction_amount invoice_id]
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
