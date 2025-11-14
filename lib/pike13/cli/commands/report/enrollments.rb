# frozen_string_literal: true

require_relative "../concerns/reporting_query"

module Pike13
  module CLI
    module Commands
      class Report < Base
        class Enrollments < Base
          include Concerns::ReportingQuery

          desc "query", "Query enrollments report"
          def query
            handle_error do
              params = build_query_params
              params[:fields] ||= %w[enrollment_id completed_at person_full_name event_occurrence_name state]
              result = with_progress("Fetching enrollments report") do
                Pike13::Reporting::Enrollments.query(**params)
              end
              output(result)
            end
          end
        end
      end
    end
  end
end
