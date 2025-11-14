# frozen_string_literal: true

require "pike13"
require "thor"
require "json"

require_relative "cli/version"
require_relative "cli/config"
require_relative "cli/formatter"
require_relative "cli/commands/desk"
require_relative "cli/commands/front"
require_relative "cli/commands/account"
require_relative "cli/commands/report"

module Pike13
  module CLI
    class Runner < Thor
      class_option :verbose, type: :boolean, aliases: "-v", desc: "Verbose output"
      class_option :quiet, type: :boolean, aliases: "-q", desc: "Quiet mode (errors only)"

      desc "desk SUBCOMMAND", "Desk namespace (staff interface)"
      subcommand "desk", Commands::Desk

      desc "front SUBCOMMAND", "Front namespace (client interface)"
      subcommand "front", Commands::Front

      desc "account SUBCOMMAND", "Account namespace"
      subcommand "account", Commands::Account

      desc "report SUBCOMMAND", "Reporting API"
      subcommand "report", Commands::Report

      desc "version", "Show version"
      def version
        require "colorize" if $stdout.tty?

        puts "pike13-cli version #{Pike13::CLI::VERSION}".bold if $stdout.tty?
        puts "pike13-cli version #{Pike13::CLI::VERSION}" unless $stdout.tty?
        puts "pike13 gem version #{Pike13::VERSION}"
        puts "Ruby version: #{RUBY_VERSION}"
        puts ""
        puts "Environment:"
        puts "  PIKE13_ACCESS_TOKEN: #{ENV['PIKE13_ACCESS_TOKEN'] ? 'set' : 'not set'}"
        puts "  PIKE13_BASE_URL: #{ENV['PIKE13_BASE_URL'] || 'not set'}"
      end

      def self.exit_on_failure?
        true
      end

      # Hook to configure Pike13 before any command
      def self.start(given_args = ARGV, config = {})
        # Skip config for help commands
        help_commands = %w[help version] + given_args.grep(/--help/)
        unless help_commands.any? || given_args.empty?
          Config.configure_pike13!
        end
        super
      rescue StandardError => e
        puts "Error: #{e.message}"
        exit 1
      end
    end
  end
end
