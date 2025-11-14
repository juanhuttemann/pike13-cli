# frozen_string_literal: true

require "spec_helper"

RSpec.describe Pike13::CLI do
  describe "VERSION" do
    it "has a version number" do
      expect(Pike13::CLI::VERSION).not_to be_nil
    end

    it "follows semantic versioning" do
      expect(Pike13::CLI::VERSION).to match(/^\d+\.\d+\.\d+$/)
    end
  end
end
