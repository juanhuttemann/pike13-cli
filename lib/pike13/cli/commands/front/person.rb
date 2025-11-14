# frozen_string_literal: true

module Pike13
  module CLI
    module Commands
      class Front < Base
        class Person < Base
          desc "me", "Get current authenticated client user"
          format_options
          def me
            handle_error { output(Pike13::Front::Person.me) }
          end
        end
      end
    end
  end
end
