# frozen_string_literal: true

require_relative "../thor_nested_subcommand"

module Pike13
  module CLI
    module Commands
      class Base < Thor
        include ThorNestedSubcommand

        # Inherit verbose and quiet options from parent Runner
        class_option :verbose, type: :boolean, aliases: "-v", desc: "Verbose output"
        class_option :quiet, type: :boolean, aliases: "-q", desc: "Quiet mode (errors only)"

        # Auto-generate base_usage from class name
        def self.base_usage
          # Convert class name like Pike13::CLI::Commands::Report::Clients
          # to "report clients"
          namespace_parts = name.split("::")[3..] # Skip Pike13::CLI::Commands
          if namespace_parts && namespace_parts.length > 1
            # For nested classes like Report::Clients
            namespace_parts.map(&:downcase).join(" ")
          elsif namespace_parts&.length == 1
            # For top-level namespace classes
            namespace_parts.first.downcase
          else
            ""
          end
        end

        # Helper to add format options to commands
        def self.format_options
          option :format, type: :string, default: "json", desc: "Output format (json, table, csv)"
          option :compact, type: :boolean, default: false, desc: "Compact JSON output"
          option :color, type: :boolean, default: false, desc: "Colorize table output"
          option :progress, type: :boolean, default: false, desc: "Show progress indicator"
        end

        private

        def output(data)
          return if options[:quiet]

          Formatter.output(
            data,
            format: options[:format],
            compact: options[:compact],
            color: options[:color]
          )
        end

        def handle_error
          setup_verbose_mode if options && options[:verbose]
          yield
        rescue Pike13::AuthenticationError => e
          handle_authentication_error(e)
        rescue Pike13::NotFoundError => e
          handle_not_found_error(e)
        rescue Pike13::ValidationError => e
          handle_validation_error(e)
        rescue Pike13::RateLimitError => e
          handle_rate_limit_error(e)
        rescue Pike13::ServerError => e
          handle_server_error(e)
        rescue Pike13::BadRequestError => e
          handle_bad_request_error(e)
        rescue Pike13::ConnectionError => e
          handle_connection_error(e)
        rescue Pike13::APIError => e
          handle_generic_api_error(e)
        rescue StandardError => e
          handle_generic_error(e)
        end

        def with_progress(message = "Loading", &block)
          require_relative "../progress"
          Progress.run(message, enabled: options[:progress], &block)
        end

        def warn_message(msg)
          if $stdout.tty?
            require "colorize"
            puts msg.red.bold
          else
            puts msg
          end
        end

        def success_message(msg)
          return if options[:quiet]

          if $stdout.tty?
            require "colorize"
            puts msg.green
          else
            puts msg
          end
        end

        def debug_message(msg)
          return unless options[:verbose]

          if $stderr.tty?
            require "colorize"
            warn "[DEBUG] #{msg}".light_black
          else
            warn "[DEBUG] #{msg}"
          end
        end

        def setup_verbose_mode
          return unless options[:verbose]

          # Enable HTTParty debugging
          begin
            Pike13::HTTPClient.debug_output($stderr) if Pike13::HTTPClient.respond_to?(:debug_output)
          rescue StandardError
            # Silently ignore if debug_output is not available
          end

          debug_message "Verbose mode enabled - detailed logging active"
          debug_message "Pike13 Base URL: #{ENV.fetch('PIKE13_BASE_URL', nil)}"
          debug_message "Access Token: #{ENV['PIKE13_ACCESS_TOKEN'] ? '[SET]' : '[NOT SET]'}"
        end

        # Validate that a required option is present
        def validate_required(option_name)
          unless options[option_name]
            warn_message "Error: --#{option_name.to_s.gsub('_', '-')} is required"
            exit 1
          end
        end

        # Validate date format (YYYY-MM-DD)
        def validate_date_format(date_string, field_name = "date")
          return if date_string.nil?

          return if date_string =~ /^\d{4}-\d{2}-\d{2}$/

          warn_message "Error: #{field_name} must be in YYYY-MM-DD format (got: #{date_string})"
          exit 1
        end

        # Validate that an ID is numeric
        def validate_numeric_id(id, resource_name = "resource")
          return if id.to_s =~ /^\d+$/ || id.to_s =~ /^[a-f0-9-]{36}$/ # Allow UUIDs too

          warn_message "Error: #{resource_name} ID must be numeric or a valid UUID (got: #{id})"
          exit 1
        end

        # Error handlers with helpful messages
        def handle_authentication_error(error)
          warn_message "Authentication Error: Invalid or expired access token"
          warn_message ""
          warn_message "Suggestions:"
          warn_message "  1. Verify your PIKE13_ACCESS_TOKEN environment variable is set correctly"
          warn_message "  2. Check if your access token has expired"
          warn_message "  3. Generate a new access token from your Pike13 account settings"
          warn_message ""
          warn_message "Current token: #{ENV['PIKE13_ACCESS_TOKEN'] ? "#{ENV['PIKE13_ACCESS_TOKEN'][0..10]}..." : '[NOT SET]'}"
          show_verbose_error_details(error) if options && options[:verbose]
          exit 1
        end

        def handle_not_found_error(error)
          warn_message "Not Found: The requested resource does not exist"
          warn_message ""
          warn_message "Suggestions:"
          warn_message "  1. Verify the resource ID is correct"
          warn_message "  2. Check if the resource has been deleted"
          warn_message "  3. Ensure you have permission to access this resource"
          show_verbose_error_details(error) if options && options[:verbose]
          exit 1
        end

        def handle_validation_error(error)
          warn_message "Validation Error: The request contains invalid data"
          warn_message ""

          # Show main error message if available
          if error.message && !error.message.empty?
            formatted_message = format_error_message(error.message)
            warn_message "Error details: #{formatted_message}"
            warn_message ""
          end

          # Show structured response body errors if available
          if error.response_body
            details = format_validation_errors(error.response_body)
            if details && !details.empty?
              warn_message "API response: #{details}"
              warn_message ""
            end
          end

          # Show specific suggestions for common validation errors
          suggestions = get_validation_error_suggestions(error.message)
          warn_message "Suggestions:"
          suggestions.each { |suggestion| warn_message "  #{suggestion}" }

          show_verbose_error_details(error) if options && options[:verbose]
          exit 1
        end

        def handle_rate_limit_error(error)
          warn_message "Rate Limit Exceeded: Too many requests"
          warn_message ""
          if error.respond_to?(:rate_limit_reset) && error.rate_limit_reset
            warn_message "Rate limit will reset at: #{error.rate_limit_reset}"
            warn_message ""
          end
          warn_message "Suggestions:"
          warn_message "  1. Wait a few minutes before retrying"
          warn_message "  2. Reduce the frequency of your requests"
          warn_message "  3. Consider batching operations when possible"
          show_verbose_error_details(error) if options && options[:verbose]
          exit 1
        end

        def handle_server_error(error)
          warn_message "Server Error: Pike13 API is experiencing issues"
          warn_message ""
          warn_message "HTTP Status: #{error.http_status}" if error.http_status
          warn_message ""
          warn_message "Suggestions:"
          warn_message "  1. Wait a few minutes and try again"
          warn_message "  2. Check Pike13 status page for service updates"
          warn_message "  3. Contact Pike13 support if the issue persists"
          show_verbose_error_details(error) if options && options[:verbose]
          exit 1
        end

        def handle_bad_request_error(error)
          warn_message "Bad Request: The request is malformed or invalid"
          warn_message ""
          if error.response_body
            warn_message "Details: #{error.response_body}"
            warn_message ""
          end
          warn_message "Suggestions:"
          warn_message "  1. Check command syntax and options"
          warn_message "  2. Verify all required parameters are provided"
          warn_message "  3. Run with --verbose flag for more details"
          show_verbose_error_details(error) if options && options[:verbose]
          exit 1
        end

        def handle_connection_error(error)
          warn_message "Connection Error: Unable to connect to Pike13 API"
          warn_message ""
          warn_message "Error: #{error.message}"
          warn_message ""
          warn_message "Suggestions:"
          warn_message "  1. Check your internet connection"
          warn_message "  2. Verify PIKE13_BASE_URL is set correctly: #{ENV.fetch('PIKE13_BASE_URL', nil)}"
          warn_message "  3. Check if a firewall is blocking the connection"
          warn_message "  4. Verify the Pike13 service is available"
          show_verbose_error_details(error) if options && options[:verbose]
          exit 1
        end

        def handle_generic_api_error(error)
          warn_message "API Error: #{error.message}"
          warn_message ""
          warn_message "HTTP Status: #{error.http_status}" if error.http_status
          warn_message ""
          warn_message "Run with --verbose flag for more details"
          show_verbose_error_details(error) if options && options[:verbose]
          exit 1
        end

        def handle_generic_error(error)
          warn_message "Error: #{error.message}"
          warn_message ""
          warn_message "Run with --verbose flag for more details"
          show_verbose_error_details(error) if options && options[:verbose]
          exit 1
        end

        def show_verbose_error_details(error)
          warn_message ""
          warn_message "=== Verbose Error Details ==="
          warn_message "Error Class: #{error.class}"
          warn_message "HTTP Status: #{error.http_status}" if error.respond_to?(:http_status)
          if error.respond_to?(:response_body) && error.response_body
            warn_message "Response Body: #{error.response_body}"
          end
          if error.backtrace
            warn_message "Backtrace:"
            error.backtrace.first(10).each { |line| warn_message "  #{line}" }
          end
        end

        def format_validation_errors(response_body)
          case response_body
          when Hash
            if response_body["errors"]
              response_body["errors"].is_a?(Array) ? response_body["errors"].join(", ") : response_body["errors"]
            else
              response_body.to_s
            end
          when String
            response_body
          else
            response_body.to_s
          end
        end

        def get_validation_error_suggestions(error_message)
          suggestions = [
            "Check that all required fields are provided",
            "Verify field formats (dates, emails, etc.)",
            "Review the Pike13 API documentation for field requirements"
          ]

          # Add specific suggestions based on error message content
          if error_message
            if error_message.include?("active plans")
              suggestions.unshift("Cancel or end all active plans before deleting this person")
              suggestions.unshift("Use 'pike13 desk person_plans list --person-id=ID' to check for active plans")
            elsif error_message.include?("bookings")
              suggestions.unshift("Cancel or complete all active bookings before deletion")
            elsif error_message.include?("payments")
              suggestions.unshift("Ensure there are no pending payment transactions")
            elsif error_message.include?("dependencies")
              suggestions.unshift("Remove or resolve all dependencies before deletion")
            end
          end

          suggestions
        end

        def format_error_message(message)
          return nil if message.nil?

          # Handle common error message formats
          if message.include?("=>") && message.include?('"base"')
            # Parse hash-like error messages: {"base" => ["Error message"]}
            match = message.match(/\{"base"\s*=>\s*\[(.*?)\]\}/)
            return match[1].gsub('"', "").strip if match
          end

          # Clean up common formatting issues
          message.gsub(/^"|"$/, "").strip
        end
      end
    end
  end
end
