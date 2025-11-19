# frozen_string_literal: true

require "spec_helper"

RSpec.describe "Help Commands" do
  describe "main CLI help display" do
    it "displays all top-level namespace commands" do
      help_output = `bundle exec bin/pike13 --help 2>&1`
      expect(help_output).to include("pike13 account SUBCOMMAND")
      expect(help_output).to include("pike13 desk SUBCOMMAND")
      expect(help_output).to include("pike13 front SUBCOMMAND")
      expect(help_output).to include("pike13 report SUBCOMMAND")
      expect(help_output).to include("pike13 version")
    end
  end

  describe "report namespace help display" do
    it "displays report subcommands with proper namespace prefix" do
      help_output = `bundle exec bin/pike13 report --help 2>&1`
      expect(help_output).to include("pike13 report clients SUBCOMMAND")
      expect(help_output).to include("pike13 report enrollments SUBCOMMAND")
      expect(help_output).to include("pike13 report invoices SUBCOMMAND")
      expect(help_output).to include("pike13 report transactions SUBCOMMAND")
    end
  end

  describe "report subcommand help displays" do
    it "displays clients subcommand with correct namespace prefix" do
      help_output = `bundle exec bin/pike13 report clients --help 2>&1`
      expect(help_output).to include("pike13 report clients help [COMMAND]")
      expect(help_output).to include("pike13 report clients query")
    end

    it "displays enrollments subcommand with correct namespace prefix" do
      help_output = `bundle exec bin/pike13 report enrollments --help 2>&1`
      expect(help_output).to include("pike13 report enrollments help [COMMAND]")
      expect(help_output).to include("pike13 report enrollments query")
    end

    it "displays invoices subcommand with correct namespace prefix" do
      help_output = `bundle exec bin/pike13 report invoices --help 2>&1`
      expect(help_output).to include("pike13 report invoices help [COMMAND]")
      expect(help_output).to include("pike13 report invoices query")
    end
  end

  describe "account namespace help display" do
    it "displays account subcommands with proper namespace prefix" do
      help_output = `bundle exec bin/pike13 account --help 2>&1`
      expect(help_output).to include("pike13 account businesses SUBCOMMAND")
      expect(help_output).to include("pike13 account people SUBCOMMAND")
    end
  end

  describe "account subcommand help displays" do
    it "displays businesses subcommand with correct namespace prefix" do
      help_output = `bundle exec bin/pike13 account businesses --help 2>&1`
      expect(help_output).to include("pike13 account business help [COMMAND]")
      expect(help_output).to include("pike13 account business list")
    end
  end

  describe "desk namespace help display" do
    it "displays desk subcommands with proper namespace prefix" do
      help_output = `bundle exec bin/pike13 desk --help 2>&1`
      expect(help_output).to include("pike13 desk business SUBCOMMAND")
      expect(help_output).to include("pike13 desk people SUBCOMMAND")
      expect(help_output).to include("pike13 desk events SUBCOMMAND")
    end
  end

  describe "desk subcommand help displays" do
    it "displays people subcommand with correct namespace prefix" do
      help_output = `bundle exec bin/pike13 desk people --help 2>&1`
      expect(help_output).to include("pike13 desk people help [COMMAND]")
      expect(help_output).to include("pike13 desk people list")
    end

    it "displays business subcommand with correct namespace prefix" do
      help_output = `bundle exec bin/pike13 desk business --help 2>&1`
      expect(help_output).to include("pike13 desk business help [COMMAND]")
      expect(help_output).to include("pike13 desk business find")
    end
  end

  describe "front namespace help display" do
    it "displays front subcommands with proper namespace prefix" do
      help_output = `bundle exec bin/pike13 front --help 2>&1`
      expect(help_output).to include("pike13 front people SUBCOMMAND")
      expect(help_output).to include("pike13 front events SUBCOMMAND")
    end
  end

  describe "front subcommand help displays" do
    it "displays people subcommand with correct namespace prefix" do
      help_output = `bundle exec bin/pike13 front people --help 2>&1`
      expect(help_output).to include("pike13 front people help [COMMAND]")
      expect(help_output).to include("pike13 front people me")
    end

    it "displays events subcommand with correct namespace prefix" do
      help_output = `bundle exec bin/pike13 front events --help 2>&1`
      expect(help_output).to include("pike13 front event help [COMMAND]")
      expect(help_output).to include("pike13 front event list")
    end
  end

  describe "verbose flag availability in help" do
    it "includes verbose option in main help display" do
      help_output = `bundle exec bin/pike13 --help 2>&1`
      expect(help_output).to include("--verbose")
      expect(help_output).to include("Verbose output")
    end

    it "includes verbose option in subcommand help display" do
      help_output = `bundle exec bin/pike13 report clients --help 2>&1`
      expect(help_output).to include("--verbose")
      expect(help_output).to include("Verbose output")
    end
  end

  describe "help commands show proper namespace prefixes only" do
    it "does not display ghost commands without namespace prefix" do
      help_output = `bundle exec bin/pike13 report --help 2>&1`

      # Should not show these ghost commands
      expect(help_output).not_to match(/^pike13 clients\s/)
      expect(help_output).not_to match(/^pike13 enrollments\s/)
      expect(help_output).not_to match(/^pike13 invoices\s/)
      expect(help_output).not_to match(/^pike13 transactions\s/)

      # Should show properly namespaced commands
      expect(help_output).to match(/pike13 report clients/)
      expect(help_output).to match(/pike13 report enrollments/)
      expect(help_output).to match(/pike13 report invoices/)
      expect(help_output).to match(/pike13 report transactions/)
    end
  end
end
