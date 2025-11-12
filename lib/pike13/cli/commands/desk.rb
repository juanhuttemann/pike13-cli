# frozen_string_literal: true

require_relative "base"
require_relative "desk/people"
require_relative "desk/events"
require_relative "desk/event_occurrences"
require_relative "desk/bookings"
require_relative "desk/visits"
require_relative "desk/invoices"
require_relative "desk/locations"
require_relative "desk/services"
require_relative "desk/staff"
require_relative "desk/plans"

module Pike13
  module CLI
    module Commands
      class Desk < Base
        desc "people SUBCOMMAND", "Manage people"
        subcommand "people", Desk::People

        desc "events SUBCOMMAND", "Manage events"
        subcommand "events", Desk::Events

        desc "event_occurrences SUBCOMMAND", "Manage event occurrences"
        subcommand "event_occurrences", Desk::EventOccurrences

        desc "bookings SUBCOMMAND", "Manage bookings"
        subcommand "bookings", Desk::Bookings

        desc "visits SUBCOMMAND", "Manage visits"
        subcommand "visits", Desk::Visits

        desc "invoices SUBCOMMAND", "Manage invoices"
        subcommand "invoices", Desk::Invoices

        desc "locations SUBCOMMAND", "Manage locations"
        subcommand "locations", Desk::Locations

        desc "services SUBCOMMAND", "Manage services"
        subcommand "services", Desk::Services

        desc "staff SUBCOMMAND", "Manage staff members"
        subcommand "staff", Desk::Staff

        desc "plans SUBCOMMAND", "Manage plans"
        subcommand "plans", Desk::Plans
      end
    end
  end
end
