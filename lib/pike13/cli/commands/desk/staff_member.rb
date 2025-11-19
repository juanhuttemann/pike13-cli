# frozen_string_literal: true

module Pike13
  module CLI
    module Commands
      class Desk < Base
        class StaffMember < Base
          # Override the command name display to use "staff" instead of "staffmember"
          def self.base_usage
            "desk staff"
          end
          desc "list", "List all staff"
          map "ls" => :list
          format_options
          def list
            handle_error do
              result = with_progress("Fetching staff") do
                Pike13::Desk::StaffMember.all
              end
              output(result)
            end
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
