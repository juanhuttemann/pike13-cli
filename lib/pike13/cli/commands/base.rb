# frozen_string_literal: true

module Pike13
  module CLI
    module Commands
      class Base < Thor
        # Helper to add format options to commands
        def self.format_options
          option :format, type: :string, default: "json", desc: "Output format (json, table, csv)"
          option :compact, type: :boolean, default: false, desc: "Compact JSON output"
        end
        
        private

        def output(data)
          Formatter.output(
            data,
            format: options[:format],
            compact: options[:compact]
          )
        end

        def handle_error
          yield
        rescue Pike13::APIError => e
          puts "API Error: #{e.message}"
          exit 1
        rescue => e
          puts "Error: #{e.message}"
          exit 1
        end
      end
    end
  end
end
