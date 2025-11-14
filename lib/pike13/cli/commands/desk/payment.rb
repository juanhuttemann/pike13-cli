# frozen_string_literal: true

module Pike13
  module CLI
    module Commands
      class Desk < Base
        class Payment < Base
          desc "get ID", "Get a payment by ID"
          format_options
          def get(id)
            handle_error do
              result = Pike13::Desk::Payment.find(id)
              output(result)
            end
          end

          desc "configuration", "Get payment configuration"
          format_options
          def configuration
            handle_error do
              result = Pike13::Desk::Payment.configuration
              output(result)
            end
          end

          desc "void PAYMENT_ID", "Void a payment"
          format_options
          option :invoice_item_ids, type: :array, desc: "Invoice item IDs to cancel"
          def void(payment_id)
            handle_error do
              invoice_item_ids_to_cancel = options[:invoice_item_ids] || []
              result = Pike13::Desk::Payment.void(
                payment_id: payment_id,
                invoice_item_ids_to_cancel: invoice_item_ids_to_cancel
              )
              output(result)
              success_message "Payment #{payment_id} voided successfully"
            end
          end
        end
      end
    end
  end
end
