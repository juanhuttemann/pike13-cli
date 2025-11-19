# frozen_string_literal: true

module Pike13
  module CLI
    module Commands
      class Desk < Base
        class Event < Base
          desc "list", "List all events"
          map "ls" => :list
          format_options
          option :from, type: :string, desc: "Start date (YYYY-MM-DD or timestamp)"
          option :to, type: :string, desc: "End date (YYYY-MM-DD or timestamp, max 120 days from from)"
          option :ids, type: :string, desc: "Comma-separated event IDs"
          option :service_ids, type: :string, desc: "Comma-separated service IDs"
          def list
            validate_event_date_formats
            handle_error do
              params = build_event_params
              result = with_progress("Fetching events") do
                Pike13::Desk::Event.all(**params)
              end
              output(result)
            end
          end

          desc "get ID", "Get an event by ID"
          format_options
          def get(id)
            handle_error do
              result = Pike13::Desk::Event.find(id)
              output(result)
            end
          end

          private

          def validate_event_date_formats
            validate_date_format(options[:from], "from") if options[:from]
            validate_date_format(options[:to], "to") if options[:to]
          end

          def build_event_params
            params = {}
            params[:from] = options[:from] if options[:from]
            params[:to] = options[:to] if options[:to]
            params[:ids] = options[:ids] if options[:ids]
            params[:service_ids] = options[:service_ids] if options[:service_ids]
            params
          end
        end
      end
    end
  end
end
