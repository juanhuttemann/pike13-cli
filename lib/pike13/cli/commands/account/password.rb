# frozen_string_literal: true

module Pike13
  module CLI
    module Commands
      class Account < Base
        class Password < Base
          desc "reset", "Request password reset"
          format_options
          option :email, type: :string, required: true
          def reset
            handle_error do
              result = Pike13::Account::Password.create(email: options[:email])
              output(result)
            end
          end
        end
      end
    end
  end
end
