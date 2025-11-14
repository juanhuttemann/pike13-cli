# frozen_string_literal: true

module Pike13
  module CLI
    module Commands
      class Desk < Base
        class Business < Base
          desc "find", "Get business details"
          format_options
          def find
            handle_error do
              result = Pike13::Desk::Business.find
              output(result)
            end
          end
        end
      end
    end
  end
end
