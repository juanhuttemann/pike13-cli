# frozen_string_literal: true

module Pike13
  module CLI
    module Commands
      module Concerns
        # Module to add formatting capabilities to Thor commands
        # Include this in command classes and call `add_format_options` on methods
        module FormattableCommand
          def self.included(base)
            base.extend(ClassMethods)
          end

          module ClassMethods
            # Adds format and compact options to a command
            # Usage: add_format_options before defining the command method
            def add_format_options
              option :format, type: :string, default: "json", desc: "Output format (json, table, csv)"
              option :compact, type: :boolean, default: false, desc: "Compact JSON output"
            end
          end

          private

          # Output data using the formatter with current options
          def output(data)
            Pike13::CLI::Formatter.output(
              data,
              format: options[:format],
              compact: options[:compact]
            )
          end

          # Error handling wrapper
          def handle_error
            yield
          rescue Pike13::APIError => e
            puts "API Error: #{e.message}"
            exit 1
          rescue StandardError => e
            puts "Error: #{e.message}"
            exit 1
          end
        end
      end
    end
  end
end
