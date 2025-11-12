# frozen_string_literal: true

require_relative "base"

module Pike13
  module CLI
    module Commands
      class Report < Base
        desc "clients", "Query clients report"
        format_options
        option :fields, type: :array, desc: "Fields to include"
        option :filter, type: :hash, desc: "Filter criteria"
        option :group, type: :string, desc: "Group by field"
        option :sort, type: :array, desc: "Sort fields"
        def clients
          handle_error do
            params = build_query_params
            result = Pike13::Reporting::Clients.query(**params)
            output(result)
          end
        end

        desc "transactions", "Query transactions report"
        format_options
        option :fields, type: :array, desc: "Fields to include"
        option :filter, type: :hash, desc: "Filter criteria"
        option :from, type: :string, desc: "Start date"
        option :to, type: :string, desc: "End date"
        def transactions
          handle_error do
            params = build_query_params
            result = Pike13::Reporting::Transactions.query(**params)
            output(result)
          end
        end

        desc "enrollments", "Query enrollments report"
        format_options
        option :fields, type: :array, desc: "Fields to include"
        option :filter, type: :hash, desc: "Filter criteria"
        def enrollments
          handle_error do
            params = build_query_params
            result = Pike13::Reporting::Enrollments.query(**params)
            output(result)
          end
        end

        desc "monthly-metrics", "Query monthly business metrics"
        format_options
        option :fields, type: :array, desc: "Fields to include"
        option :from, type: :string, desc: "Start date"
        def monthly_metrics
          handle_error do
            params = build_query_params
            result = Pike13::Reporting::MonthlyBusinessMetrics.query(**params)
            output(result)
          end
        end

        private

        def build_query_params
          params = {}
          params[:fields] = options[:fields] if options[:fields]
          params[:filter] = options[:filter] if options[:filter]
          params[:group] = options[:group] if options[:group]
          params[:sort] = options[:sort] if options[:sort]
          params
        end
      end
    end
  end
end
