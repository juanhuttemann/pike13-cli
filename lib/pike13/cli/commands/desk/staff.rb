# frozen_string_literal: true

module Pike13
  module CLI
    module Commands
      class Desk < Base
        class Staff < Base
          desc "list", "List all staff"
          format_options
          def list
            handle_error { output(Pike13::Desk::StaffMember.all) }
          end

          desc "get ID", "Get a staff member by ID"
          format_options
          def get(id)
            handle_error { output(Pike13::Desk::StaffMember.find(id)) }
          end

          desc "me", "Get current staff user"
          format_options
          def me
            handle_error { output(Pike13::Desk::StaffMember.me) }
          end
        end
      end
    end
  end
end
