# frozen_string_literal: true

require_relative "base"
require_relative "report/clients"
require_relative "report/transactions"
require_relative "report/enrollments"
require_relative "report/monthly_business_metrics"
require_relative "report/invoices"
require_relative "report/event_occurrences"
require_relative "report/event_occurrence_staff_members"
require_relative "report/invoice_items"
require_relative "report/invoice_item_transactions"
require_relative "report/pays"
require_relative "report/person_plans"
require_relative "report/staff_members"

module Pike13
  module CLI
    module Commands
      class Report < Base
        desc "clients SUBCOMMAND", "Query clients report"
        subcommand "clients", Report::Clients

        desc "transactions SUBCOMMAND", "Query transactions report"
        subcommand "transactions", Report::Transactions

        desc "tx SUBCOMMAND", "Query transactions report (shortcut)"
        subcommand "tx", Report::Transactions

        desc "enrollments SUBCOMMAND", "Query enrollments report"
        subcommand "enrollments", Report::Enrollments

        desc "monthly_metrics SUBCOMMAND", "Query monthly business metrics"
        subcommand "monthly_metrics", Report::MonthlyBusinessMetrics

        desc "mm SUBCOMMAND", "Query monthly business metrics (shortcut)"
        subcommand "mm", Report::MonthlyBusinessMetrics

        desc "invoices SUBCOMMAND", "Query invoices report"
        subcommand "invoices", Report::Invoices

        desc "event_occurrences SUBCOMMAND", "Query event occurrences report"
        subcommand "event_occurrences", Report::EventOccurrences

        desc "eo SUBCOMMAND", "Query event occurrences report (shortcut)"
        subcommand "eo", Report::EventOccurrences

        desc "event_occurrence_staff SUBCOMMAND", "Query event occurrence staff members report"
        subcommand "event_occurrence_staff", Report::EventOccurrenceStaffMembers

        desc "eos SUBCOMMAND", "Query event occurrence staff members report (shortcut)"
        subcommand "eos", Report::EventOccurrenceStaffMembers

        desc "invoice_items SUBCOMMAND", "Query invoice items report"
        subcommand "invoice_items", Report::InvoiceItems

        desc "ii SUBCOMMAND", "Query invoice items report (shortcut)"
        subcommand "ii", Report::InvoiceItems

        desc "invoice_item_transactions SUBCOMMAND", "Query invoice item transactions report"
        subcommand "invoice_item_transactions", Report::InvoiceItemTransactions

        desc "iit SUBCOMMAND", "Query invoice item transactions report (shortcut)"
        subcommand "iit", Report::InvoiceItemTransactions

        desc "pays SUBCOMMAND", "Query pays report"
        subcommand "pays", Report::Pays

        desc "person_plans SUBCOMMAND", "Query person plans report"
        subcommand "person_plans", Report::PersonPlans

        desc "staff_members SUBCOMMAND", "Query staff members report"
        subcommand "staff_members", Report::StaffMembers
      end
    end
  end
end
