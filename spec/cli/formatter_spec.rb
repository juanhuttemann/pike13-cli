# frozen_string_literal: true

require "spec_helper"

RSpec.describe Pike13::CLI::Formatter do
  describe ".extract_array_from_response" do
    context "with an array" do
      it "returns the array as-is" do
        data = [{ "id" => 1, "name" => "Test" }]
        expect(described_class.extract_array_from_response(data)).to eq(data)
      end
    end

    context "with a hash containing an array value" do
      it "extracts the array value" do
        data = { "people" => [{ "id" => 1 }], "meta" => {} }
        result = described_class.extract_array_from_response(data)
        expect(result).to eq([{ "id" => 1 }])
      end
    end

    context "with reporting API v3 format" do
      it "converts rows to hashes using field names" do
        data = {
          "data" => {
            "attributes" => {
              "fields" => [
                { "name" => "id" },
                { "name" => "name" }
              ],
              "rows" => [
                [1, "John"],
                [2, "Jane"]
              ]
            }
          }
        }
        result = described_class.extract_array_from_response(data)
        expect(result).to eq([
                               { "id" => 1, "name" => "John" },
                               { "id" => 2, "name" => "Jane" }
                             ])
      end
    end

    context "with a single hash" do
      it "wraps it in an array" do
        data = { "id" => 1, "name" => "Test" }
        expect(described_class.extract_array_from_response(data)).to eq([data])
      end
    end
  end

  describe ".truncate" do
    it "returns string as-is if shorter than max_length" do
      expect(described_class.truncate("short", 10)).to eq("short")
    end

    it "truncates long strings with ellipsis" do
      result = described_class.truncate("this is a very long string", 10)
      expect(result).to eq("this is...")
      expect(result.length).to eq(10)
    end
  end

  describe ".csv_escape" do
    it "returns empty string for nil" do
      expect(described_class.csv_escape(nil)).to eq("")
    end

    it "returns string as-is if no special characters" do
      expect(described_class.csv_escape("simple")).to eq("simple")
    end

    it "wraps and escapes strings with commas" do
      expect(described_class.csv_escape("hello, world")).to eq('"hello, world"')
    end

    it "wraps and escapes strings with quotes" do
      expect(described_class.csv_escape('say "hi"')).to eq('"say ""hi"""')
    end

    it "wraps strings with newlines" do
      expect(described_class.csv_escape("line1\nline2")).to eq("\"line1\nline2\"")
    end
  end

  describe ".calculate_column_widths" do
    let(:headers) { %w[id name email] }
    let(:items) do
      [
        { "id" => 1, "name" => "John", "email" => "john@example.com" },
        { "id" => 2, "name" => "Jane Smith", "email" => "jane@example.com" }
      ]
    end

    it "calculates appropriate widths for each column" do
      widths = described_class.calculate_column_widths(headers, items)
      expect(widths).to be_an(Array)
      expect(widths.length).to eq(3)
      expect(widths.all? { |w| w >= 10 }).to be true # All at least min_width
    end

    it "respects max_width constraint" do
      widths = described_class.calculate_column_widths(headers, items, max_width: 20)
      expect(widths.all? { |w| w <= 20 }).to be true
    end

    it "respects min_width constraint" do
      widths = described_class.calculate_column_widths(["a"], [{ "a" => "x" }], min_width: 15)
      expect(widths.first).to eq(15)
    end
  end
end
