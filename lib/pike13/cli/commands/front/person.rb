# frozen_string_literal: true

module Pike13
  module CLI
    module Commands
      class Front < Base
        class Person < Base
          # Override the command name display to use "people" instead of "person"
          def self.base_usage
            "front people"
          end
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
