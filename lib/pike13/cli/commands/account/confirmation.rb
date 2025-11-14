# frozen_string_literal: true

module Pike13
  module CLI
    module Commands
      class Account < Base
        class Confirmation < Base
          desc "create", "Create confirmation with token"
          format_options
          option :token, type: :string, required: true, desc: "Confirmation token"
          def create
            handle_error do
              result = Pike13::Account::Confirmation.create(confirmation_token: options[:token])
              output(result)
            end
          end
        end
      end
    end
  end
end
