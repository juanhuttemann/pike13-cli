# frozen_string_literal: true

RSpec.describe Pike13::CLI::Commands::Front::PlanProduct do
  let(:command) { described_class.new }
  let(:product_id) { "123" }

  describe "#list" do
    before do
      allow(Pike13::Front::PlanProduct).to receive(:all)
        .and_return([{ id: product_id, name: "Client Plan Product" }])
    end

    it "calls PlanProduct.all from the SDK" do
      expect(Pike13::Front::PlanProduct).to receive(:all)

      command.invoke(:list)
    end

    it "outputs the plan products list" do
      expect { command.invoke(:list) }
        .to output(/Client Plan Product/).to_stdout
    end
  end

  describe "#get" do
    before do
      allow(Pike13::Front::PlanProduct).to receive(:find)
        .with(product_id)
        .and_return({ id: product_id, name: "Client Plan Product", price: 79.99 })
    end

    it "calls PlanProduct.find from the SDK" do
      expect(Pike13::Front::PlanProduct).to receive(:find)
        .with(product_id)

      command.invoke(:get, [product_id])
    end

    it "outputs the plan product details" do
      expect { command.invoke(:get, [product_id]) }
        .to output(/79\.99/).to_stdout
    end
  end
end
