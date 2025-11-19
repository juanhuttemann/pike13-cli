# frozen_string_literal: true

module Pike13
  module CLI
    module Commands
      class Desk < Base
        class Person < Base
          desc "list", "List all people"
          map "ls" => :list
          format_options
          option :created_since, type: :string, desc: "Filter to people created since given timestamp (ISO 8601)"
          option :updated_since, type: :string, desc: "Filter to people updated since given timestamp (ISO 8601)"
          option :is_member, type: :boolean, desc: "Filter to people with current membership"
          option :include_relationships, type: :boolean, desc: "Include providers and dependents for each person"
          option :include_balances, type: :boolean, desc: "Include balances for each person"
          option :sort, type: :string,
                        desc: "Sort results by attributes (updated_at, created_at, id). Use - for descending"
          def list
            handle_error do
              params = build_person_params
              result = with_progress("Fetching people") do
                Pike13::Desk::Person.all(**params)
              end
              output(result)
            end
          end

          desc "get ID", "Get a person by ID"
          format_options
          def get(id)
            handle_error do
              result = Pike13::Desk::Person.find(id)
              output(result)
            end
          end

          desc "search QUERY", "Search for people"
          format_options
          option :fields, type: :string, desc: "Fields to search in"
          def search(query)
            handle_error do
              result = Pike13::Desk::Person.search(query, fields: options[:fields])
              output(result)
            end
          end

          desc "me", "Get current authenticated user"
          format_options
          def me
            handle_error do
              result = Pike13::Desk::Person.me
              output(result)
            end
          end

          desc "create", "Create a new person"
          format_options
          option :first_name, type: :string, required: true
          option :last_name, type: :string, required: true
          option :email, type: :string, required: true
          option :phone, type: :string
          def create
            handle_error do
              attributes = {
                first_name: options[:first_name],
                last_name: options[:last_name],
                email: options[:email]
              }
              attributes[:phone] = options[:phone] if options[:phone]

              result = Pike13::Desk::Person.create(attributes)
              output(result)
            end
          end

          desc "update ID", "Update a person"
          format_options
          option :first_name, type: :string
          option :last_name, type: :string
          option :email, type: :string
          option :phone, type: :string
          def update(id)
            handle_error do
              attributes = {}
              attributes[:first_name] = options[:first_name] if options[:first_name]
              attributes[:last_name] = options[:last_name] if options[:last_name]
              attributes[:email] = options[:email] if options[:email]
              attributes[:phone] = options[:phone] if options[:phone]

              result = Pike13::Desk::Person.update(id, attributes)
              output(result)
            end
          end

          desc "delete ID", "Delete a person"
          def delete(id)
            handle_error do
              Pike13::Desk::Person.destroy(id)
              success_message "Person #{id} deleted successfully"
            end
          end

          private

          def build_person_params
            params = {}
            params[:created_since] = options[:created_since] if options[:created_since]
            params[:updated_since] = options[:updated_since] if options[:updated_since]
            params[:is_member] = options[:is_member] unless options[:is_member].nil?
            [
              [:include_relationships, options[:include_relationships]],
              [:include_balances, options[:include_balances]],
              [:sort, options[:sort]]
            ].each { |key, value| params[key] = value if value }
            params
          end
        end
      end
    end
  end
end
