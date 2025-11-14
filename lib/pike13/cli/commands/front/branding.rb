# frozen_string_literal: true

module Pike13
  module CLI
    module Commands
      class Front < Base
        class Branding < Base
          desc "show", "Get branding"
          format_options
          def show
            handle_error { output(Pike13::Front::Branding.find) }
          end
        end
      end
    end
  end
end
