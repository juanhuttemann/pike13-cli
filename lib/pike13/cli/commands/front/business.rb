# frozen_string_literal: true

module Pike13
  module CLI
    module Commands
      class Front < Base
        class Business < Base
          desc "show", "Get business info"
          format_options
          def show
            handle_error { output(Pike13::Front::Business.find) }
          end
        end
      end
    end
  end
end
