# frozen_string_literal: true

require_relative "base"
require_relative "front/person"
require_relative "front/event"
require_relative "front/event_occurrence"
require_relative "front/event_occurrence_note"
require_relative "front/event_occurrence_waitlist_eligibility"
require_relative "front/plan_product"
require_relative "front/plan_terms"
require_relative "front/service"
require_relative "front/location"
require_relative "front/appointment"
require_relative "front/booking"
require_relative "front/business"
require_relative "front/branding"
require_relative "front/person_visit"
require_relative "front/person_plan"
require_relative "front/person_waitlist_entry"
require_relative "front/person_waiver"
require_relative "front/form_of_payment"

module Pike13
  module CLI
    module Commands
      class Front < Base
        desc "people SUBCOMMAND", "Manage people"
        subcommand "people", Front::Person

        desc "events SUBCOMMAND", "Manage events"
        subcommand "events", Front::Event

        desc "event_occurrences SUBCOMMAND", "Manage event occurrences"
        subcommand "event_occurrences", Front::EventOccurrence

        desc "eo SUBCOMMAND", "Manage event occurrences (shortcut)"
        subcommand "eo", Front::EventOccurrence

        desc "event_occurrence_notes SUBCOMMAND", "Manage event occurrence notes"
        subcommand "event_occurrence_notes", Front::EventOccurrenceNote

        desc "eon SUBCOMMAND", "Manage event occurrence notes (shortcut)"
        subcommand "eon", Front::EventOccurrenceNote

        desc "event_occurrence_waitlist_eligibilities SUBCOMMAND", "Manage waitlist eligibility"
        subcommand "event_occurrence_waitlist_eligibilities", Front::EventOccurrenceWaitlistEligibility

        desc "eowe SUBCOMMAND", "Manage waitlist eligibility (shortcut)"
        subcommand "eowe", Front::EventOccurrenceWaitlistEligibility

        desc "plan_products SUBCOMMAND", "Manage plan products"
        subcommand "plan_products", Front::PlanProduct

        desc "pp SUBCOMMAND", "Manage plan products (shortcut)"
        subcommand "pp", Front::PlanProduct

        desc "plan_terms SUBCOMMAND", "Manage plan terms"
        subcommand "plan_terms", Front::PlanTerms

        desc "pt SUBCOMMAND", "Manage plan terms (shortcut)"
        subcommand "pt", Front::PlanTerms

        desc "services SUBCOMMAND", "Manage services"
        subcommand "services", Front::Service

        desc "locations SUBCOMMAND", "Manage locations"
        subcommand "locations", Front::Location

        desc "appointments SUBCOMMAND", "Manage appointments"
        subcommand "appointments", Front::Appointment

        desc "bookings SUBCOMMAND", "Manage bookings"
        subcommand "bookings", Front::Booking

        desc "business SUBCOMMAND", "Business info"
        subcommand "business", Front::Business

        desc "branding SUBCOMMAND", "Branding info"
        subcommand "branding", Front::Branding

        desc "person_visits SUBCOMMAND", "Manage person visits"
        subcommand "person_visits", Front::PersonVisit

        desc "pv SUBCOMMAND", "Manage person visits (shortcut)"
        subcommand "pv", Front::PersonVisit

        desc "person_plans SUBCOMMAND", "Manage person plans"
        subcommand "person_plans", Front::PersonPlan

        desc "ppl SUBCOMMAND", "Manage person plans (shortcut)"
        subcommand "ppl", Front::PersonPlan

        desc "person_waitlist SUBCOMMAND", "Manage person waitlist entries"
        subcommand "person_waitlist", Front::PersonWaitlistEntry

        desc "pwl SUBCOMMAND", "Manage person waitlist entries (shortcut)"
        subcommand "pwl", Front::PersonWaitlistEntry

        desc "person_waivers SUBCOMMAND", "Manage person waivers"
        subcommand "person_waivers", Front::PersonWaiver

        desc "pw SUBCOMMAND", "Manage person waivers (shortcut)"
        subcommand "pw", Front::PersonWaiver

        desc "forms_of_payment SUBCOMMAND", "Manage forms of payment"
        subcommand "forms_of_payment", Front::FormOfPayment

        desc "fop SUBCOMMAND", "Manage forms of payment (shortcut)"
        subcommand "fop", Front::FormOfPayment
      end
    end
  end
end
