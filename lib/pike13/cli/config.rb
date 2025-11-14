# frozen_string_literal: true

module Pike13
  module CLI
    # Configuration management for Pike13 CLI
    # Reads credentials from environment variables
    class Config
      # Configure the Pike13 gem with credentials from environment
      #
      # @raise [RuntimeError] if required environment variables are missing
      # @return [void]
      def self.configure_pike13!
        access_token = ENV.fetch("PIKE13_ACCESS_TOKEN", nil)
        base_url = ENV.fetch("PIKE13_BASE_URL", nil)

        raise "PIKE13_ACCESS_TOKEN environment variable is required" unless access_token
        raise "PIKE13_BASE_URL environment variable is required" unless base_url

        Pike13.configure do |config|
          config.access_token = access_token
          config.base_url = base_url
        end
      end
    end
  end
end
