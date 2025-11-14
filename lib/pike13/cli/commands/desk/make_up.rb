# frozen_string_literal: true

module Pike13
  module CLI
    module Commands
      class Desk < Base
        class MakeUp < Base
          desc "get ID", "Get a make-up by ID"
          format_options
          def get(id)
            handle_error do
              result = Pike13::Desk::MakeUp.find(id)
              output(result)
            end
          end

          desc "reasons", "List make-up reasons"
          format_options
          def reasons
            handle_error do
              result = with_progress("Fetching make-up reasons") do
                Pike13::Desk::MakeUp.reasons
              end
              output(result)
            end
          end

          desc "generate VISIT_ID", "Generate a make-up credit"
          format_options
          option :make_up_reason_id, type: :numeric, required: true, desc: "Make-up reason ID"
          option :free_form_reason, type: :string, desc: "Free form reason text"
          def generate(visit_id)
            handle_error do
              result = Pike13::Desk::MakeUp.generate(
                visit_id: visit_id,
                make_up_reason_id: options[:make_up_reason_id],
                free_form_reason: options[:free_form_reason]
              )
              output(result)
              success_message "Make-up generated successfully"
            end
          end
        end
      end
    end
  end
end
