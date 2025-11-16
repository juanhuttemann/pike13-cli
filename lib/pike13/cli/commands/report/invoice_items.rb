# frozen_string_literal: true

require_relative "../concerns/reporting_query"

module Pike13
  module CLI
    module Commands
      class Report < Base
        class InvoiceItems < Base
          # Override base_usage to match the actual subcommand registration
          def self.base_usage
            "report invoice_items"
          end
          include Concerns::ReportingQuery

          desc "query", "Query invoice items report"
          def query
            handle_error do
              params = build_query_params
              params[:fields] ||= %w[invoice_item_id product_name expected_amount net_paid_amount]
              result = with_progress("Fetching invoice items report") do
                Pike13::Reporting::InvoiceItems.query(**params)
              end
              output(result)
            end
          end
        end
      end
    end
  end
end
