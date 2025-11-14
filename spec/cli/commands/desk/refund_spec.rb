# frozen_string_literal: true

RSpec.describe Pike13::CLI::Commands::Desk::Refund do
  let(:command) { described_class.new }
  let(:refund_id) { "123" }

  describe "#get" do
    before do
      allow(Pike13::Desk::Refund).to receive(:find)
        .with(refund_id)
        .and_return({ id: refund_id, amount: 50.00 })
    end

    it "calls Refund.find from the SDK" do
      expect(Pike13::Desk::Refund).to receive(:find)
        .with(refund_id)

      command.invoke(:get, [refund_id])
    end

    it "outputs the refund details" do
      expect { command.invoke(:get, [refund_id]) }
        .to output(/50\.0/).to_stdout
    end
  end

  describe "#void" do
    before do
      allow(Pike13::Desk::Refund).to receive(:void)
        .with(refund_id: refund_id)
        .and_return({ id: refund_id, voided: true })
    end

    it "calls Refund.void from the SDK" do
      expect(Pike13::Desk::Refund).to receive(:void)
        .with(refund_id: refund_id)

      command.invoke(:void, [refund_id])
    end

    it "outputs the void result" do
      expect { command.invoke(:void, [refund_id]) }
        .to output(/voided/).to_stdout
    end
  end
end
