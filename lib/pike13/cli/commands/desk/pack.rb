# frozen_string_literal: true

module Pike13
  module CLI
    module Commands
      class Desk < Base
        class Pack < Base
          desc "get ID", "Get a pack by ID"
          format_options
          def get(id)
            handle_error do
              result = Pike13::Desk::Pack.find(id)
              output(result)
            end
          end
        end
      end
    end
  end
end
