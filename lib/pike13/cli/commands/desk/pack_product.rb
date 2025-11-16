# frozen_string_literal: true

module Pike13
  module CLI
    module Commands
      class Desk < Base
        class PackProduct < Base
          # Override base_usage to match the actual subcommand registration
          def self.base_usage
            "desk pack_products"
          end
          desc "list", "List all pack products"
          format_options
          def list
            handle_error do
              result = with_progress("Fetching pack products") do
                Pike13::Desk::PackProduct.all
              end
              output(result)
            end
          end

          desc "get ID", "Get a pack product by ID"
          format_options
          def get(id)
            handle_error do
              result = Pike13::Desk::PackProduct.find(id)
              output(result)
            end
          end

          desc "create", "Create a pack product"
          format_options
          option :name, type: :string, required: true, desc: "Pack product name"
          option :description, type: :string, desc: "Pack product description"
          option :price, type: :numeric, required: true, desc: "Pack product price"
          option :visit_count, type: :numeric, required: true, desc: "Number of visits"
          def create
            handle_error do
              attributes = {
                name: options[:name],
                description: options[:description],
                price: options[:price],
                visit_count: options[:visit_count]
              }
              result = with_progress("Creating pack product") do
                Pike13::Desk::PackProduct.create(attributes: attributes)
              end
              output(result)
            end
          end

          desc "update ID", "Update a pack product"
          format_options
          option :name, type: :string, desc: "Updated pack product name"
          option :description, type: :string, desc: "Updated pack product description"
          option :price, type: :numeric, desc: "Updated pack product price"
          option :visit_count, type: :numeric, desc: "Updated number of visits"
          def update(id)
            handle_error do
              attributes = {}
              attributes[:name] = options[:name] if options[:name]
              attributes[:description] = options[:description] if options[:description]
              attributes[:price] = options[:price] if options[:price]
              attributes[:visit_count] = options[:visit_count] if options[:visit_count]

              result = with_progress("Updating pack product") do
                Pike13::Desk::PackProduct.update(id, attributes: attributes)
              end
              output(result)
            end
          end

          desc "delete ID", "Delete a pack product"
          format_options
          def delete(id)
            handle_error do
              result = with_progress("Deleting pack product") do
                Pike13::Desk::PackProduct.destroy(id)
              end
              output(result)
            end
          end

          desc "create-pack PACK_PRODUCT_ID", "Create a pack within a pack product"
          format_options
          option :person_id, type: :numeric, required: true, desc: "Person ID to assign pack to"
          def create_pack(pack_product_id)
            handle_error do
              attributes = { person_id: options[:person_id].to_i }
              result = with_progress("Creating pack") do
                Pike13::Desk::PackProduct.create_pack(pack_product_id, attributes)
              end
              output(result)
            end
          end
        end
      end
    end
  end
end
