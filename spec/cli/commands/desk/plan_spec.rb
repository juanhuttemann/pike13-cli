# frozen_string_literal: true

RSpec.describe Pike13::CLI::Commands::Desk::Plan do
  let(:command) { described_class.new }

  describe "#list" do
    before do
      allow(Pike13::Desk::Plan).to receive(:all)
        .and_return([{ id: 1, name: "Monthly Membership", price: 99.00 }])
    end

    it "calls Plan.all from the SDK" do
      expect(Pike13::Desk::Plan).to receive(:all)

      command.invoke(:list)
    end

    it "outputs the plans list" do
      expect { command.invoke(:list) }
        .to output(/Monthly Membership/).to_stdout
    end
  end

  describe "#get" do
    let(:plan_id) { "1" }

    before do
      allow(Pike13::Desk::Plan).to receive(:find)
        .with(plan_id)
        .and_return({ id: plan_id, name: "Monthly Membership", price: 99.00 })
    end

    it "calls Plan.find from the SDK" do
      expect(Pike13::Desk::Plan).to receive(:find)
        .with(plan_id)

      command.invoke(:get, [plan_id])
    end

    it "outputs the plan details" do
      expect { command.invoke(:get, [plan_id]) }
        .to output(/99\.0/).to_stdout
    end
  end
end
