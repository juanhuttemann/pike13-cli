# frozen_string_literal: true

module Pike13
  module CLI
    module Commands
      class Front < Base
        class FormOfPayment < Base
          desc "list PERSON_ID", "List forms of payment for a person (client view)"
          format_options
          def list(person_id)
            handle_error do
              result = with_progress("Fetching forms of payment") do
                Pike13::Front::FormOfPayment.all(person_id: person_id)
              end
              output(result)
            end
          end

          desc "get PERSON_ID FOP_ID", "Get a form of payment by ID (client view)"
          format_options
          def get(person_id, fop_id)
            handle_error do
              result = Pike13::Front::FormOfPayment.find(person_id: person_id, id: fop_id)
              output(result)
            end
          end

          desc "me FOP_ID", "Get own form of payment by ID (client view)"
          format_options
          def me(fop_id)
            handle_error do
              result = Pike13::Front::FormOfPayment.find_me(id: fop_id)
              output(result)
            end
          end

          desc "create PERSON_ID", "Create a form of payment (client view)"
          format_options
          option :type, type: :string, required: true, desc: "Payment type (creditcard, ach, etc.)"
          option :token, type: :string, required: true, desc: "Payment token from payment processor"
          option :is_default, type: :boolean, default: false, desc: "Set as default payment method"
          def create(person_id)
            handle_error do
              attributes = {
                type: options[:type],
                token: options[:token],
                is_default: options[:is_default]
              }
              result = Pike13::Front::FormOfPayment.create(person_id: person_id, attributes: attributes)
              output(result)
              success_message "Form of payment created successfully"
            end
          end

          desc "update PERSON_ID FOP_ID", "Update a form of payment (client view)"
          format_options
          option :is_default, type: :boolean, desc: "Set as default payment method"
          def update(person_id, fop_id)
            handle_error do
              attributes = {}
              attributes[:is_default] = options[:is_default] if options.key?(:is_default)
              result = Pike13::Front::FormOfPayment.update(person_id: person_id, id: fop_id, attributes: attributes)
              output(result)
              success_message "Form of payment updated successfully"
            end
          end

          desc "delete PERSON_ID FOP_ID", "Delete a form of payment (client view)"
          def delete(person_id, fop_id)
            handle_error do
              Pike13::Front::FormOfPayment.destroy(person_id: person_id, id: fop_id)
              success_message "Form of payment #{fop_id} deleted successfully"
            end
          end
        end
      end
    end
  end
end
