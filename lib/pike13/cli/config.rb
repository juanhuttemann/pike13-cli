# frozen_string_literal: true

module Pike13
  module CLI
    class Config
      def self.configure_pike13!
        access_token = ENV["PIKE13_ACCESS_TOKEN"]
        base_url = ENV["PIKE13_BASE_URL"]

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
