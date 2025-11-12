# frozen_string_literal: true

require "json"

module Pike13
  module CLI
    class Formatter
      # Output data in the specified format
      # The SDK returns raw API responses (Hash or Array)
      def self.output(data, format: :json, compact: false)
        case format.to_sym
        when :json
          puts compact ? JSON.generate(data) : JSON.pretty_generate(data)
        when :table
          output_table(data)
        when :csv
          output_csv(data)
        else
          puts JSON.pretty_generate(data)
        end
      end

      def self.output_table(data)
        return puts "No data" if data.nil? || (data.respond_to?(:empty?) && data.empty?)

        # Extract array from wrapper if needed
        items = extract_array_from_response(data)
        return puts "No data" if items.empty?
        
        # Get headers from first item
        first = items.first
        return puts "No data" if first.nil?
        
        headers = first.is_a?(Hash) ? first.keys : ["value"]
        
        # Print header
        puts headers.join(" | ")
        puts "-" * (headers.map { |h| h.to_s.length }.sum + (headers.length - 1) * 3)
        
        # Print rows
        items.each do |item|
          if item.is_a?(Hash)
            puts headers.map { |h| truncate(item[h].to_s, 50) }.join(" | ")
          else
            puts truncate(item.to_s, 50)
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

      def self.truncate(str, max_length)
        str.length > max_length ? "#{str[0...max_length - 3]}..." : str
      end

      def self.csv_escape(value)
        return "" if value.nil?
        str = value.to_s
        str.include?(",") || str.include?('"') || str.include?("\n") ? "\"#{str.gsub('"', '""')}\"" : str
      end
    end
  end
end
