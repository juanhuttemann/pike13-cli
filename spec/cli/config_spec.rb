# frozen_string_literal: true

require "spec_helper"

RSpec.describe Pike13::CLI::Config do
  describe ".configure_pike13!" do
    context "when environment variables are set" do
      before do
        ENV["PIKE13_ACCESS_TOKEN"] = "test_token"
        ENV["PIKE13_BASE_URL"] = "test.pike13.com"
      end

      after do
        ENV.delete("PIKE13_ACCESS_TOKEN")
        ENV.delete("PIKE13_BASE_URL")
      end

      it "configures Pike13 gem" do
        expect { described_class.configure_pike13! }.not_to raise_error
      end
    end

    context "when PIKE13_ACCESS_TOKEN is missing" do
      before do
        ENV.delete("PIKE13_ACCESS_TOKEN")
        ENV["PIKE13_BASE_URL"] = "test.pike13.com"
      end

      after do
        ENV.delete("PIKE13_BASE_URL")
      end

      it "raises an error" do
        expect { described_class.configure_pike13! }.to raise_error(RuntimeError, /PIKE13_ACCESS_TOKEN/)
      end
    end

    context "when PIKE13_BASE_URL is missing" do
      before do
        ENV["PIKE13_ACCESS_TOKEN"] = "test_token"
        ENV.delete("PIKE13_BASE_URL")
      end

      after do
        ENV.delete("PIKE13_ACCESS_TOKEN")
      end

      it "raises an error" do
        expect { described_class.configure_pike13! }.to raise_error(RuntimeError, /PIKE13_BASE_URL/)
      end
    end
  end
end
