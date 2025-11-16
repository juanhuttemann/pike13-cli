# frozen_string_literal: true

module Pike13
  module CLI
    module Commands
      class Front < Base
        class EventOccurrence < Base
          # Override base_usage to match the actual subcommand registration
          def self.base_usage
            "front event_occurrences"
          end
          desc "list", "List event occurrences (client view)"
          format_options
          option :from, type: :string, desc: "Start date (YYYY-MM-DD)"
          option :to, type: :string, desc: "End date (YYYY-MM-DD)"
          def list
            validate_date_format(options[:from], "from") if options[:from]
            validate_date_format(options[:to], "to") if options[:to]

            handle_error do
              params = {}
              params[:from] = options[:from] if options[:from]
              params[:to] = options[:to] if options[:to]

              result = with_progress("Fetching event occurrences") do
                Pike13::Front::EventOccurrence.all(**params)
              end
              output(result)
            end
          end
        end
      end
    end
  end
end
