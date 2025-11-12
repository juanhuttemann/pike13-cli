# frozen_string_literal: true

require_relative "base"

module Pike13
  module CLI
    module Commands
      class Account < Base
        desc "me", "Get current account"
        format_options
        def me
          handle_error { output(Pike13::Account.me) }
        end

        desc "businesses", "List all businesses"
        format_options
        def businesses
          handle_error { output(Pike13::Account::Business.all) }
        end

        desc "people", "List all people across businesses"
        format_options
        def people
          handle_error { output(Pike13::Account::Person.all) }
        end

        desc "password-reset", "Request password reset"
        format_options
        option :email, type: :string, required: true
        def password_reset
          handle_error do
            result = Pike13::Account::Password.create(email: options[:email])
            output(result)
          end
        end
      end
    end
  end
end
