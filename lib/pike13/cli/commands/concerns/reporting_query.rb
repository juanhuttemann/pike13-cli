# frozen_string_literal: true

module Pike13
  module CLI
    module Commands
      module Concerns
        module ReportingQuery
          def self.included(base)
            base.class_eval do
              format_options
              option :fields, type: :array, desc: "Fields to include (defaults to basic fields)"
              option :filter, type: :hash, desc: "Filter criteria"
              option :group, type: :string, desc: "Group by field"
              option :sort, type: :array, desc: "Sort fields"
              option :page, type: :hash, desc: "Pagination options"
              option :total_count, type: :boolean, desc: "Include total count in response"
            end
          end

          private

          # rubocop:disable Metrics/AbcSize
          def build_query_params
            params = {}

            # Handle fields - support comma-separated strings and arrays
            if options[:fields]
              params[:fields] = parse_array_option(options[:fields])
            end

            params[:filter] = options[:filter] if options[:filter]
            params[:group] = options[:group] if options[:group]

            # Handle sort - support comma-separated strings and arrays
            if options[:sort]
              params[:sort] = parse_array_option(options[:sort])
            end

            params[:page] = options[:page] if options[:page]
            params[:total_count] = options[:total_count] if options[:total_count]
            params
          end

          # Parse option that can be either a comma-separated string or an array
          def parse_array_option(option)
            if option.is_a?(Array) && option.size == 1 && option.first.include?(",")
              option.first.split(",").map(&:strip)
            elsif option.is_a?(String) && option.include?(",")
              option.split(",").map(&:strip)
            else
              option
            end
          end
          # rubocop:enable Metrics/AbcSize
        end
      end
    end
  end
end
