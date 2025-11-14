# frozen_string_literal: true

module Pike13
  module CLI
    module Commands
      class Front < Base
        class PlanTerms < Base
          desc "list PLAN_ID", "List plan terms for a plan"
          format_options
          def list(plan_id)
            handle_error do
              result = with_progress("Fetching plan terms") do
                Pike13::Front::PlanTerms.all(plan_id: plan_id)
              end
              output(result)
            end
          end

          desc "get PLAN_ID TERMS_ID", "Get specific plan terms"
          format_options
          def get(plan_id, terms_id)
            handle_error do
              result = Pike13::Front::PlanTerms.find(plan_id: plan_id, plan_terms_id: terms_id)
              output(result)
            end
          end

          desc "complete PLAN_ID TERMS_ID", "Complete plan terms"
          format_options
          def complete(plan_id, terms_id)
            handle_error do
              result = with_progress("Completing plan terms") do
                Pike13::Front::PlanTerms.complete(plan_id: plan_id, plan_terms_id: terms_id)
              end
              output(result)
            end
          end
        end
      end
    end
  end
end
