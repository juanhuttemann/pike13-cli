# frozen_string_literal: true

require "json"
require "colorize"

module Pike13
  module CLI
    # Handles output formatting for CLI commands
    # Supports JSON, table, and CSV formats
    class Formatter
      # Output data in the specified format
      # The SDK returns raw API responses (Hash or Array)
      #
      # @param data [Hash, Array] The data to format and output
      # @param format [Symbol, String] Output format (:json, :table, or :csv)
      # @param compact [Boolean] Whether to use compact JSON (no pretty printing)
      # @param color [Boolean] Whether to use colored output
      # @return [void]
      def self.output(data, format: :json, compact: false, color: false)
        case format.to_sym
        when :json
          puts compact ? JSON.generate(data) : JSON.pretty_generate(data)
        when :table
          output_table(data, color: color)
        when :csv
          output_csv(data)
        else
          puts JSON.pretty_generate(data)
        end
      end

      def self.output_table(data, color: false)
        return puts "No data" if data.nil? || (data.respond_to?(:empty?) && data.empty?)

        # Extract array from wrapper if needed
        items = extract_array_from_response(data)
        return puts "No data" if items.empty?

        # Get headers from first item
        first = items.first
        return puts "No data" if first.nil?

        headers = first.is_a?(Hash) ? first.keys : ["value"]

        # Calculate optimal column widths
        col_widths = calculate_column_widths(headers, items)

        # Print header
        header_line = headers.map.with_index { |h, i| h.to_s.ljust(col_widths[i]) }.join(" | ")
        puts color ? header_line.bold.cyan : header_line
        puts "-" * header_line.length

        # Print rows
        items.each do |item|
          if item.is_a?(Hash)
            row = headers.map.with_index do |h, i|
              truncate(item[h].to_s, col_widths[i]).ljust(col_widths[i])
            end
            puts row.join(" | ")
          else
            puts truncate(item.to_s, col_widths[0])
          end
        end
      end

      def self.output_csv(data)
        return puts "" if data.nil? || (data.respond_to?(:empty?) && data.empty?)

        # Extract array from wrapper if needed
        items = extract_array_from_response(data)
        return puts "" if items.empty?

        first = items.first
        return puts "" if first.nil? || !first.is_a?(Hash)

        headers = first.keys

        # Print CSV header
        puts headers.join(",")

        # Print CSV rows
        items.each do |item|
          puts headers.map { |h| csv_escape(item[h]) }.join(",")
        end
      end

      def self.extract_array_from_response(data)
        case data
        when Array
          data
        when Hash
          # Handle reporting API response (v3)
          if data.dig("data", "attributes", "rows")
            rows = data.dig("data", "attributes", "rows")
            fields = data.dig("data", "attributes", "fields") || []
            # Convert rows (arrays) to hashes using field names
            return rows.map do |row|
              fields.each_with_index.to_h { |field, i| [field["name"], row[i]] }
            end
          end

          # Try to find an array value in the hash (common API response pattern)
          # Look for keys like "locations", "people", "events", etc.
          array_value = data.values.find { |v| v.is_a?(Array) }
          array_value || [data]
        else
          [data]
        end
      end

      def self.calculate_column_widths(headers, items, max_width: 50, min_width: 10)
        # Calculate the width needed for each column
        headers.map.with_index do |header, _i|
          # Start with header width
          max_len = header.to_s.length

          # Check data widths (sample first 100 rows for performance)
          items.first(100).each do |item|
            next unless item.is_a?(Hash)

            value_len = item[header].to_s.length
            max_len = value_len if value_len > max_len
          end

          # Constrain to min/max
          max_len.clamp(min_width, max_width)
        end
      end

      def self.truncate(str, max_length)
        str.length > max_length ? "#{str[0...(max_length - 3)]}..." : str
      end

      def self.csv_escape(value)
        return "" if value.nil?

        str = value.to_s
        str.include?(",") || str.include?('"') || str.include?("\n") ? "\"#{str.gsub('"', '""')}\"" : str
      end
    end
  end
end
