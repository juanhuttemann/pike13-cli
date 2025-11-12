# frozen_string_literal: true

module Pike13
  module CLI
    module Commands
      class Desk < Base
        class Visits < Base
          desc "list", "List all visits"
          format_options
          def list
            handle_error { output(Pike13::Desk::Visit.all) }
          end

          desc "get ID", "Get a visit by ID"
          def get(id)
            handle_error { output(Pike13::Desk::Visit.find(id)) }
          end

          desc "summary", "Get visit summary for a person"
          option :person_id, type: :numeric, required: true
          def summary
            handle_error { output(Pike13::Desk::Visit.summary(person_id: options[:person_id])) }
          end
        end
      end
    end
  end
end
