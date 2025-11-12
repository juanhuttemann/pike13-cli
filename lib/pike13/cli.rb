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
        puts "pike13-cli version #{Pike13::CLI::VERSION}"
        puts "pike13 gem version #{Pike13::VERSION}"
      end

      def self.exit_on_failure?
        true
      end

      # Hook to configure Pike13 before any command
      def self.start(given_args = ARGV, config = {})
        # Skip config for help commands
        unless given_args.include?("help") || given_args.include?("version") || given_args.empty?
          Config.configure_pike13!
        end
        super
      rescue => e
        puts "Error: #{e.message}"
        exit 1
      end
    end
  end
end
