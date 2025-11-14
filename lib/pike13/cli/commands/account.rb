# frozen_string_literal: true

require_relative "base"
require_relative "account/business"
require_relative "account/person"
require_relative "account/password"
require_relative "account/confirmation"

module Pike13
  module CLI
    module Commands
      class Account < Base
        desc "me", "Get current account"
        format_options
        def me
          handle_error { output(Pike13::Account.me) }
        end

        desc "businesses SUBCOMMAND", "Manage businesses"
        subcommand "businesses", Account::Business

        desc "people SUBCOMMAND", "Manage people"
        subcommand "people", Account::Person

        desc "password SUBCOMMAND", "Manage password"
        subcommand "password", Account::Password

        desc "confirmation SUBCOMMAND", "Manage account confirmation"
        subcommand "confirmation", Account::Confirmation
      end
    end
  end
end
