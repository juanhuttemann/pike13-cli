# frozen_string_literal: true

RSpec.describe Pike13::CLI::Commands::Desk::PackProduct do
  let(:command) { described_class.new }
  let(:product_id) { "789" }

  describe "#list" do
    before do
      allow(Pike13::Desk::PackProduct).to receive(:all)
        .and_return([{ id: product_id, name: "Test Pack Product" }])
    end

    it "calls PackProduct.all from the SDK" do
      expect(Pike13::Desk::PackProduct).to receive(:all)

      command.invoke(:list)
    end

    it "outputs the pack products list" do
      expect { command.invoke(:list) }
        .to output(/Test Pack Product/).to_stdout
    end
  end

  describe "#get" do
    before do
      allow(Pike13::Desk::PackProduct).to receive(:find)
        .with(product_id)
        .and_return({ id: product_id, name: "Test Pack Product", visit_count: 10 })
    end

    it "calls PackProduct.find from the SDK" do
      expect(Pike13::Desk::PackProduct).to receive(:find)
        .with(product_id)

      command.invoke(:get, [product_id])
    end

    it "outputs the pack product details" do
      expect { command.invoke(:get, [product_id]) }
        .to output(/10/).to_stdout
    end
  end

  describe "#create" do
    let(:attributes) do
      {
        name: "New Pack Product",
        description: "A test pack product",
        price: 199.99,
        visit_count: 5
      }
    end

    before do
      allow(Pike13::Desk::PackProduct).to receive(:create)
        .with(attributes: attributes)
        .and_return({ id: product_id, **attributes })
    end

    it "calls PackProduct.create from the SDK" do
      expect(Pike13::Desk::PackProduct).to receive(:create)
        .with(attributes: attributes)

      command.invoke(:create, [], attributes)
    end

    it "outputs the created pack product" do
      expect { command.invoke(:create, [], attributes) }
        .to output(/New Pack Product/).to_stdout
    end
  end

  describe "#update" do
    let(:update_attrs) { { name: "Updated Pack Product" } }

    before do
      allow(Pike13::Desk::PackProduct).to receive(:update)
        .with(product_id, attributes: update_attrs)
        .and_return({ id: product_id, **update_attrs })
    end

    it "calls PackProduct.update from the SDK" do
      expect(Pike13::Desk::PackProduct).to receive(:update)
        .with(product_id, attributes: update_attrs)

      command.invoke(:update, [product_id], update_attrs)
    end

    it "outputs the updated pack product" do
      expect { command.invoke(:update, [product_id], update_attrs) }
        .to output(/Updated Pack Product/).to_stdout
    end
  end

  describe "#delete" do
    before do
      allow(Pike13::Desk::PackProduct).to receive(:destroy)
        .with(product_id)
        .and_return({ deleted: true })
    end

    it "calls PackProduct.destroy from the SDK" do
      expect(Pike13::Desk::PackProduct).to receive(:destroy)
        .with(product_id)

      command.invoke(:delete, [product_id])
    end

    it "outputs the deletion result" do
      expect { command.invoke(:delete, [product_id]) }
        .to output(/deleted/).to_stdout
    end
  end

  describe "#create_pack" do
    let(:person_id) { "999" }

    before do
      allow(Pike13::Desk::PackProduct).to receive(:create_pack)
        .with(product_id, { person_id: person_id.to_i })
        .and_return({ id: "pack-123", pack_product_id: product_id, person_id: person_id })
    end

    it "calls PackProduct.create_pack from the SDK" do
      expect(Pike13::Desk::PackProduct).to receive(:create_pack)
        .with(product_id, { person_id: person_id.to_i })

      command.invoke(:create_pack, [product_id], { person_id: person_id })
    end

    it "outputs the created pack" do
      expect { command.invoke(:create_pack, [product_id], { person_id: person_id }) }
        .to output(/pack-123/).to_stdout
    end
  end
end
