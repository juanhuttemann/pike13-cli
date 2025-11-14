# frozen_string_literal: true

require_relative "../concerns/reporting_query"

module Pike13
  module CLI
    module Commands
      class Report < Base
        class StaffMembers < Base
          include Concerns::ReportingQuery

          desc "query", "Query staff members report"
          def query
            handle_error do
              params = build_query_params
              result = with_progress("Fetching staff members report") do
                Pike13::Reporting::StaffMembers.query(**params)
              end
              output(result)
            end
          end
        end
      end
    end
  end
end
