# frozen_string_literal: true

require "spec_helper"

RSpec.describe Pike13::CLI::Commands::Base do
  let(:command) do
    cmd = described_class.allocate
    cmd.instance_variable_set(:@options, {})
    allow(cmd).to receive(:options).and_return(cmd.instance_variable_get(:@options))
    cmd
  end

  describe "#validate_date_format" do
    it "returns nil for valid date" do
      expect(command.send(:validate_date_format, "2024-01-15")).to be_nil
    end

    it "returns nil for nil date" do
      expect(command.send(:validate_date_format, nil)).to be_nil
    end

    it "exits for invalid date format" do
      expect(command).to receive(:warn_message).with(/YYYY-MM-DD/)
      expect { command.send(:validate_date_format, "2024/01/15") }.to raise_error(SystemExit)
    end

    it "exits for incomplete date" do
      expect(command).to receive(:warn_message)
      expect { command.send(:validate_date_format, "2024-01") }.to raise_error(SystemExit)
    end
  end

  describe "#validate_numeric_id" do
    it "returns nil for numeric ID" do
      expect(command.send(:validate_numeric_id, "123")).to be_nil
    end

    it "returns nil for UUID" do
      uuid = "550e8400-e29b-41d4-a716-446655440000"
      expect(command.send(:validate_numeric_id, uuid)).to be_nil
    end

    it "exits for non-numeric ID" do
      expect(command).to receive(:warn_message)
      expect { command.send(:validate_numeric_id, "abc") }.to raise_error(SystemExit)
    end
  end

  describe "#validate_required" do
    it "returns nil when option is present" do
      allow(command).to receive(:options).and_return({ name: "test" })
      expect(command.send(:validate_required, :name)).to be_nil
    end

    it "exits when option is missing" do
      allow(command).to receive(:options).and_return({})
      expect(command).to receive(:warn_message).with(/--name is required/)
      expect { command.send(:validate_required, :name) }.to raise_error(SystemExit)
    end
  end

  describe "#format_validation_errors" do
    it "formats hash with errors array" do
      response = { "errors" => %w[error1 error2] }
      result = command.send(:format_validation_errors, response)
      expect(result).to eq("error1, error2")
    end

    it "formats hash with errors string" do
      response = { "errors" => "single error" }
      result = command.send(:format_validation_errors, response)
      expect(result).to eq("single error")
    end

    it "formats hash without errors key" do
      response = { "message" => "error" }
      result = command.send(:format_validation_errors, response)
      expect(result).to include("message")
    end

    it "formats string response" do
      response = "error message"
      result = command.send(:format_validation_errors, response)
      expect(result).to eq("error message")
    end
  end

  describe "#warn_message" do
    it "outputs message" do
      allow($stdout).to receive(:tty?).and_return(false)
      expect { command.send(:warn_message, "test") }.to output(/test/).to_stdout
    end
  end

  describe "#success_message" do
    it "outputs message when not quiet" do
      allow(command).to receive(:options).and_return({ quiet: false })
      allow($stdout).to receive(:tty?).and_return(false)
      expect { command.send(:success_message, "success") }.to output(/success/).to_stdout
    end

    it "does not output when quiet" do
      allow(command).to receive(:options).and_return({ quiet: true })
      expect { command.send(:success_message, "success") }.not_to output.to_stdout
    end
  end

  describe "#debug_message" do
    it "outputs message when verbose" do
      allow(command).to receive(:options).and_return({ verbose: true })
      allow($stderr).to receive(:tty?).and_return(false)
      expect { command.send(:debug_message, "debug") }.to output(/DEBUG.*debug/).to_stderr
    end

    it "does not output when not verbose" do
      allow(command).to receive(:options).and_return({ verbose: false })
      expect { command.send(:debug_message, "debug") }.not_to output.to_stderr
    end
  end

  describe "#setup_verbose_mode" do
    it "logs debug messages when verbose" do
      allow(command).to receive(:options).and_return({ verbose: true })
      ENV["PIKE13_BASE_URL"] = "test.pike13.com"
      ENV["PIKE13_ACCESS_TOKEN"] = "token"

      expect(command).to receive(:debug_message).at_least(:once)
      command.send(:setup_verbose_mode)

      ENV.delete("PIKE13_BASE_URL")
      ENV.delete("PIKE13_ACCESS_TOKEN")
    end

    it "does nothing when not verbose" do
      allow(command).to receive(:options).and_return({ verbose: false })
      expect(command).not_to receive(:debug_message)
      command.send(:setup_verbose_mode)
    end
  end
end
