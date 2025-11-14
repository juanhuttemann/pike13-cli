# frozen_string_literal: true

require_relative "../concerns/reporting_query"

module Pike13
  module CLI
    module Commands
      class Report < Base
        class Clients < Base
          include Concerns::ReportingQuery

          desc "query", "Query clients report"
          def query
            handle_error do
              params = build_query_params
              params[:fields] ||= %w[person_id full_name email client_since_date]
              result = with_progress("Fetching clients report") do
                Pike13::Reporting::Clients.query(**params)
              end
              output(result)
            end
          end
        end
      end
    end
  end
end
