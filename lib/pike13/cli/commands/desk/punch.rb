# frozen_string_literal: true

module Pike13
  module CLI
    module Commands
      class Desk < Base
        class Punch < Base
          desc "get ID", "Get a punch by ID"
          format_options
          def get(id)
            handle_error do
              result = Pike13::Desk::Punch.find(id)
              output(result)
            end
          end
        end
      end
    end
  end
end
