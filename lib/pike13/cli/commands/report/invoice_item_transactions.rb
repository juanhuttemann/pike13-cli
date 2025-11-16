# frozen_string_literal: true

require_relative "../concerns/reporting_query"

module Pike13
  module CLI
    module Commands
      class Report < Base
        class InvoiceItemTransactions < Base
          # Override base_usage to match the actual subcommand registration
          def self.base_usage
            "report invoice_item_transactions"
          end
          include Concerns::ReportingQuery

          desc "query", "Query invoice item transactions report"
          def query
            handle_error do
              params = build_query_params
              params[:fields] ||= %w[transaction_id transaction_date payment_method net_paid_amount]
              result = with_progress("Fetching invoice item transactions report") do
                Pike13::Reporting::InvoiceItemTransactions.query(**params)
              end
              output(result)
            end
          end
        end
      end
    end
  end
end
