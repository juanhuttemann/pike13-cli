# frozen_string_literal: true

module Pike13
  module CLI
    module Commands
      class Desk < Base
        class Booking < Base
          desc "get ID", "Get a booking by ID"
          format_options
          def get(id)
            handle_error do
              result = Pike13::Desk::Booking.find(id)
              output(result)
            end
          end

          desc "create", "Create a booking"
          format_options
          option :event_occurrence_id, type: :numeric, required: true
          option :person_id, type: :numeric, required: true
          def create
            handle_error do
              require "securerandom"
              result = Pike13::Desk::Booking.create(
                event_occurrence_id: options[:event_occurrence_id],
                person_id: options[:person_id],
                idempotency_token: SecureRandom.uuid
              )
              output(result)
            end
          end

          desc "update ID", "Update a booking"
          format_options
          option :state, type: :string, desc: "Booking state"
          def update(id)
            handle_error do
              attributes = {}
              attributes[:state] = options[:state] if options[:state]
              result = Pike13::Desk::Booking.update(id, attributes)
              output(result)
            end
          end

          desc "delete ID", "Delete a booking"
          def delete(id)
            handle_error do
              Pike13::Desk::Booking.destroy(id)
              success_message "Booking #{id} deleted successfully"
            end
          end
        end
      end
    end
  end
end
