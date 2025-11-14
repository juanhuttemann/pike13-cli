# frozen_string_literal: true

module Pike13
  module CLI
    module Commands
      class Desk < Base
        class Refund < Base
          desc "get ID", "Get a refund by ID"
          format_options
          def get(id)
            handle_error do
              result = Pike13::Desk::Refund.find(id)
              output(result)
            end
          end

          desc "void ID", "Void a refund"
          format_options
          def void(id)
            handle_error do
              result = with_progress("Voiding refund") do
                Pike13::Desk::Refund.void(refund_id: id)
              end
              output(result)
            end
          end
        end
      end
    end
  end
end
