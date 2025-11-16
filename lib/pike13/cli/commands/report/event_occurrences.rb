# frozen_string_literal: true

require_relative "../concerns/reporting_query"

module Pike13
  module CLI
    module Commands
      class Report < Base
        class EventOccurrences < Base
          # Override base_usage to match the actual subcommand registration
          def self.base_usage
            "report event_occurrences"
          end
          include Concerns::ReportingQuery

          desc "query", "Query event occurrences report"
          def query
            handle_error do
              params = build_query_params
              params[:fields] ||= %w[event_occurrence_id event_name service_date enrollment_count capacity]
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
