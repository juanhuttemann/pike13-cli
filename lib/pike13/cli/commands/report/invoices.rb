# frozen_string_literal: true

require_relative "../concerns/reporting_query"

module Pike13
  module CLI
    module Commands
      class Report < Base
        class Invoices < Base
          include Concerns::ReportingQuery

          desc "query", "Query invoices report"
          def query
            handle_error do
              params = build_query_params
              params[:fields] ||= %w[invoice_id invoice_number expected_amount outstanding_amount invoice_state]
              result = with_progress("Fetching invoices report") do
                Pike13::Reporting::Invoices.query(**params)
              end
              output(result)
            end
          end
        end
      end
    end
  end
end
