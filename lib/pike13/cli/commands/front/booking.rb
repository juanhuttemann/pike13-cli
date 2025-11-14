# frozen_string_literal: true

module Pike13
  module CLI
    module Commands
      class Front < Base
        class Booking < Base
          desc "get ID", "Get a booking by ID (client view)"
          format_options
          def get(id)
            handle_error { output(Pike13::Front::Booking.find(id)) }
          end

          desc "create", "Create a booking (client view)"
          format_options
          option :event_occurrence_id, type: :numeric, required: true, desc: "Event occurrence ID"
          option :person_id, type: :numeric, required: true, desc: "Person ID"
          def create
            handle_error do
              require "securerandom"
              attributes = {
                event_occurrence_id: options[:event_occurrence_id],
                person_id: options[:person_id],
                idempotency_token: SecureRandom.uuid
              }
              result = Pike13::Front::Booking.create(attributes)
              output(result)
              success_message "Booking created successfully"
            end
          end

          desc "update ID", "Update a booking (client view)"
          format_options
          option :state, type: :string, desc: "Booking state"
          def update(id)
            handle_error do
              attributes = {}
              attributes[:state] = options[:state] if options[:state]
              result = Pike13::Front::Booking.update(id, attributes)
              output(result)
              success_message "Booking updated successfully"
            end
          end

          desc "delete ID", "Delete a booking (client view)"
          def delete(id)
            handle_error do
              Pike13::Front::Booking.destroy(id)
              success_message "Booking #{id} deleted successfully"
            end
          end
        end
      end
    end
  end
end
