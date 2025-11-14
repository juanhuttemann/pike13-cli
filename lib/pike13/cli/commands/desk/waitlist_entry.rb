# frozen_string_literal: true

module Pike13
  module CLI
    module Commands
      class Desk < Base
        class WaitlistEntry < Base
          desc "list", "List waitlist entries"
          map "ls" => :list
          format_options
          def list
            handle_error do
              result = with_progress("Fetching waitlist entries") do
                Pike13::Desk::WaitlistEntry.all
              end
              output(result)
            end
          end

          desc "get ID", "Get a waitlist entry by ID"
          format_options
          def get(id)
            handle_error do
              result = Pike13::Desk::WaitlistEntry.find(id)
              output(result)
            end
          end

          desc "create", "Create a waitlist entry"
          format_options
          option :person_id, type: :numeric, required: true, desc: "Person ID"
          option :event_id, type: :numeric, required: true, desc: "Event ID"
          def create
            handle_error do
              attributes = {
                person_id: options[:person_id],
                event_id: options[:event_id]
              }
              result = Pike13::Desk::WaitlistEntry.create(attributes)
              output(result)
              success_message "Waitlist entry created successfully"
            end
          end

          desc "update ID", "Update a waitlist entry"
          format_options
          option :state, type: :string, desc: "Waitlist entry state"
          def update(id)
            handle_error do
              attributes = {}
              attributes[:state] = options[:state] if options[:state]
              result = Pike13::Desk::WaitlistEntry.update(id, attributes)
              output(result)
              success_message "Waitlist entry updated successfully"
            end
          end

          desc "delete ID", "Delete a waitlist entry"
          def delete(id)
            handle_error do
              Pike13::Desk::WaitlistEntry.destroy(id)
              success_message "Waitlist entry #{id} deleted successfully"
            end
          end
        end
      end
    end
  end
end
