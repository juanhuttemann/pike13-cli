# frozen_string_literal: true

require_relative "base"

module Pike13
  module CLI
    module Commands
      class Front < Base
        desc "people-me", "Get current authenticated client user"
        format_options
        def people_me
          handle_error { output(Pike13::Front::Person.me) }
        end

        desc "events-list", "List events (client view)"
        format_options
        def events_list
          handle_error { output(Pike13::Front::Event.all) }
        end

        desc "locations-list", "List locations (client view)"
        format_options
        def locations_list
          handle_error { output(Pike13::Front::Location.all) }
        end

        desc "business", "Get business info"
        format_options
        def business
          handle_error { output(Pike13::Front::Business.find) }
        end

        desc "branding", "Get branding"
        format_options
        def branding
          handle_error { output(Pike13::Front::Branding.find) }
        end
      end
    end
  end
end
