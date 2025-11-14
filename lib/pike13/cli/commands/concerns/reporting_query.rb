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
            params[:fields] = options[:fields] if options[:fields]
            params[:filter] = options[:filter] if options[:filter]
            params[:group] = options[:group] if options[:group]
            params[:sort] = options[:sort] if options[:sort]
            params[:page] = options[:page] if options[:page]
            params[:total_count] = options[:total_count] if options[:total_count]
            params
          end
          # rubocop:enable Metrics/AbcSize
        end
      end
    end
  end
end
