# frozen_string_literal: true

module Pike13
  module CLI
    module Commands
      class Desk < Base
        class People < Base
          desc "list", "List all people"
          format_options
          def list
            handle_error do
              result = Pike13::Desk::Person.all
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
              puts "Person #{id} deleted successfully"
            end
          end
        end
      end
    end
  end
end
