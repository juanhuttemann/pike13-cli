# frozen_string_literal: true

require_relative "../concerns/reporting_query"

module Pike13
  module CLI
    module Commands
      class Report < Base
        class EventOccurrences < Base
          include Concerns::ReportingQuery

          desc "query", "Query event occurrences report"
          def query
            handle_error do
              params = build_query_params
              result = with_progress("Fetching event occurrences report") do
                Pike13::Reporting::EventOccurrences.query(**params)
              end
              output(result)
            end
          end
        end
      end
    end
  end
end
