# frozen_string_literal: true

RSpec.describe Pike13::CLI::Commands::Desk::PlanProduct do
  let(:command) { described_class.new }
  let(:product_id) { "123" }

  describe "#list" do
    before do
      allow(Pike13::Desk::PlanProduct).to receive(:all)
        .and_return([{ id: product_id, name: "Test Plan Product" }])
    end

    it "calls PlanProduct.all from the SDK" do
      expect(Pike13::Desk::PlanProduct).to receive(:all)

      command.invoke(:list)
    end

    it "outputs the plan products list" do
      expect { command.invoke(:list) }
        .to output(/Test Plan Product/).to_stdout
    end
  end

  describe "#get" do
    before do
      allow(Pike13::Desk::PlanProduct).to receive(:find)
        .with(product_id)
        .and_return({ id: product_id, name: "Test Plan Product", price: 99.99 })
    end

    it "calls PlanProduct.find from the SDK" do
      expect(Pike13::Desk::PlanProduct).to receive(:find)
        .with(product_id)

      command.invoke(:get, [product_id])
    end

    it "outputs the plan product details" do
      expect { command.invoke(:get, [product_id]) }
        .to output(/99\.99/).to_stdout
    end
  end
end
