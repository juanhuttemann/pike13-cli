# frozen_string_literal: true

require_relative "../concerns/reporting_query"

module Pike13
  module CLI
    module Commands
      class Report < Base
        class EventOccurrenceStaffMembers < Base
          # Override base_usage to match the actual subcommand registration
          def self.base_usage
            "report event_occurrence_staff"
          end
          include Concerns::ReportingQuery

          desc "query", "Query event occurrence staff members report"
          def query
            handle_error do
              params = build_query_params
              params[:fields] ||= %w[person_id full_name event_name service_date enrollment_count]
              result = with_progress("Fetching event occurrence staff members report") do
                Pike13::Reporting::EventOccurrenceStaffMembers.query(**params)
              end
              output(result)
            end
          end
        end
      end
    end
  end
end
