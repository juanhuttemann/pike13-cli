# frozen_string_literal: true

module Pike13
  module CLI
    module Commands
      class Desk < Base
        class EventOccurrences < Base
          desc "list", "List event occurrences"
          format_options
          option :from, type: :string, desc: "Start date (YYYY-MM-DD)"
          option :to, type: :string, desc: "End date (YYYY-MM-DD)"
          def list
            handle_error do
              params = {}
              params[:from] = options[:from] if options[:from]
              params[:to] = options[:to] if options[:to]
              
              result = Pike13::Desk::EventOccurrence.all(**params)
              output(result)
            end
          end

          desc "get ID", "Get an event occurrence by ID"
          format_options
          def get(id)
            handle_error do
              result = Pike13::Desk::EventOccurrence.find(id)
              output(result)
            end
          end

          desc "summary", "Get event occurrence summary"
          format_options
          def summary
            handle_error do
              result = Pike13::Desk::EventOccurrence.summary
              output(result)
            end
          end

          desc "eligibilities ID", "Get enrollment eligibilities for an event occurrence"
          format_options
          def eligibilities(id)
            handle_error do
              result = Pike13::Desk::EventOccurrence.enrollment_eligibilities(id: id)
              output(result)
            end
          end
        end
      end
    end
  end
end
