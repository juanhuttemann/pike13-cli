# frozen_string_literal: true

module Pike13
  module CLI
    module Commands
      class Desk < Base
        class Appointment < Base
          desc "available SERVICE_ID", "Find available appointment slots for a service"
          format_options
          option :date, type: :string, required: true, desc: "Date to check (YYYY-MM-DD)"
          option :location_ids, type: :array, desc: "Location IDs to filter by"
          option :staff_member_ids, type: :array, desc: "Staff member IDs to filter by"
          def available(service_id)
            # Validate date format
            validate_date_format(options[:date], "date")

            handle_error do
              params = { date: options[:date] }
              params[:location_ids] = options[:location_ids] if options[:location_ids]
              params[:staff_member_ids] = options[:staff_member_ids] if options[:staff_member_ids]

              result = with_progress("Fetching available slots") do
                Pike13::Desk::Appointment.find_available_slots(service_id: service_id, **params)
              end
              output(result)
            end
          end

          desc "summary SERVICE_ID", "Get appointment availability summary for a service"
          format_options
          option :from, type: :string, required: true, desc: "Start date (YYYY-MM-DD)"
          option :to, type: :string, required: true, desc: "End date (YYYY-MM-DD)"
          option :location_ids, type: :array, desc: "Location IDs to filter by"
          option :staff_member_ids, type: :array, desc: "Staff member IDs to filter by"
          def summary(service_id)
            # Validate date formats
            validate_date_format(options[:from], "from")
            validate_date_format(options[:to], "to")

            handle_error do
              params = {
                from: options[:from],
                to: options[:to]
              }
              params[:location_ids] = options[:location_ids] if options[:location_ids]
              params[:staff_member_ids] = options[:staff_member_ids] if options[:staff_member_ids]

              result = with_progress("Fetching availability summary") do
                Pike13::Desk::Appointment.available_slots_summary(service_id: service_id, **params)
              end
              output(result)
            end
          end
        end
      end
    end
  end
end
