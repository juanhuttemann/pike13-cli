# frozen_string_literal: true

require_relative "base"
require_relative "desk/person"
require_relative "desk/event"
require_relative "desk/event_occurrence"
require_relative "desk/event_occurrence_note"
require_relative "desk/event_occurrence_visit"
require_relative "desk/event_occurrence_waitlist_entry"
require_relative "desk/booking"
require_relative "desk/appointment"
require_relative "desk/visit"
require_relative "desk/invoice"
require_relative "desk/payment"
require_relative "desk/refund"
require_relative "desk/location"
require_relative "desk/service"
require_relative "desk/staff_member"
require_relative "desk/plan"
require_relative "desk/note"
require_relative "desk/custom_field"
require_relative "desk/revenue_category"
require_relative "desk/sales_tax"
require_relative "desk/make_up"
require_relative "desk/waitlist_entry"
require_relative "desk/person_visit"
require_relative "desk/person_plan"
require_relative "desk/person_waitlist_entry"
require_relative "desk/person_waiver"
require_relative "desk/form_of_payment"
require_relative "desk/pack"
require_relative "desk/punch"
require_relative "desk/plan_product"
require_relative "desk/pack_product"
require_relative "desk/business"

module Pike13
  module CLI
    module Commands
      class Desk < Base
        desc "business SUBCOMMAND", "Manage business details"
        subcommand "business", Desk::Business

        desc "people SUBCOMMAND", "Manage people"
        subcommand "people", Desk::Person

        desc "events SUBCOMMAND", "Manage events"
        subcommand "events", Desk::Event

        desc "event_occurrences SUBCOMMAND", "Manage event occurrences"
        subcommand "event_occurrences", Desk::EventOccurrence

        desc "event_occurrence_notes SUBCOMMAND", "Manage event occurrence notes"
        subcommand "event_occurrence_notes", Desk::EventOccurrenceNote

        desc "event_occurrence_visits SUBCOMMAND", "Manage event occurrence visits"
        subcommand "event_occurrence_visits", Desk::EventOccurrenceVisit

        desc "event_occurrence_waitlist_entries SUBCOMMAND", "Manage event occurrence waitlist entries"
        subcommand "event_occurrence_waitlist_entries", Desk::EventOccurrenceWaitlistEntry

        desc "bookings SUBCOMMAND", "Manage bookings"
        subcommand "bookings", Desk::Booking

        desc "appointments SUBCOMMAND", "Manage appointments"
        subcommand "appointments", Desk::Appointment

        desc "visits SUBCOMMAND", "Manage visits"
        subcommand "visits", Desk::Visit

        desc "invoices SUBCOMMAND", "Manage invoices"
        subcommand "invoices", Desk::Invoice

        desc "payments SUBCOMMAND", "Manage payments"
        subcommand "payments", Desk::Payment

        desc "refunds SUBCOMMAND", "Manage refunds"
        subcommand "refunds", Desk::Refund

        desc "locations SUBCOMMAND", "Manage locations"
        subcommand "locations", Desk::Location

        desc "services SUBCOMMAND", "Manage services"
        subcommand "services", Desk::Service

        desc "staff SUBCOMMAND", "Manage staff members"
        subcommand "staff", Desk::StaffMember

        desc "plans SUBCOMMAND", "Manage plans"
        subcommand "plans", Desk::Plan

        desc "notes SUBCOMMAND", "Manage person notes"
        subcommand "notes", Desk::Note

        desc "custom_fields SUBCOMMAND", "Manage custom fields"
        subcommand "custom_fields", Desk::CustomField

        desc "revenue_categories SUBCOMMAND", "Manage revenue categories"
        subcommand "revenue_categories", Desk::RevenueCategory

        desc "sales_taxes SUBCOMMAND", "Manage sales taxes"
        subcommand "sales_taxes", Desk::SalesTax

        desc "make_ups SUBCOMMAND", "Manage make-ups"
        subcommand "make_ups", Desk::MakeUp

        desc "waitlist SUBCOMMAND", "Manage waitlist entries"
        subcommand "waitlist", Desk::WaitlistEntry

        desc "person_visits SUBCOMMAND", "Manage person visits"
        subcommand "person_visits", Desk::PersonVisit

        desc "person_plans SUBCOMMAND", "Manage person plans"
        subcommand "person_plans", Desk::PersonPlan

        desc "person_waitlist SUBCOMMAND", "Manage person waitlist entries"
        subcommand "person_waitlist", Desk::PersonWaitlistEntry

        desc "person_waivers SUBCOMMAND", "Manage person waivers"
        subcommand "person_waivers", Desk::PersonWaiver

        desc "forms_of_payment SUBCOMMAND", "Manage forms of payment"
        subcommand "forms_of_payment", Desk::FormOfPayment

        desc "packs SUBCOMMAND", "Manage packs"
        subcommand "packs", Desk::Pack

        desc "punches SUBCOMMAND", "Manage punches"
        subcommand "punches", Desk::Punch

        desc "plan_products SUBCOMMAND", "Manage plan products"
        subcommand "plan_products", Desk::PlanProduct

        desc "pack_products SUBCOMMAND", "Manage pack products"
        subcommand "pack_products", Desk::PackProduct
      end
    end
  end
end
