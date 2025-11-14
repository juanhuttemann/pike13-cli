# frozen_string_literal: true

module Pike13
  module CLI
    module Commands
      class Front < Base
        class Appointment < Base
          desc "available SERVICE_ID", "Find available appointment slots (client view)"
          format_options
          option :date, type: :string, required: true, desc: "Date to check (YYYY-MM-DD)"
          option :location_ids, type: :array, desc: "Location IDs to filter by"
          option :staff_member_ids, type: :array, desc: "Staff member IDs to filter by"
          def available(service_id)
            validate_date_format(options[:date], "date")

            handle_error do
              params = { date: options[:date] }
              params[:location_ids] = options[:location_ids] if options[:location_ids]
              params[:staff_member_ids] = options[:staff_member_ids] if options[:staff_member_ids]

              result = with_progress("Fetching available slots") do
                Pike13::Front::Appointment.find_available_slots(service_id: service_id, **params)
              end
              output(result)
            end
          end
        end
      end
    end
  end
end
