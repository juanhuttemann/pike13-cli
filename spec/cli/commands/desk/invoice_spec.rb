# frozen_string_literal: true

RSpec.describe Pike13::CLI::Commands::Desk::Invoice do
  let(:command) { described_class.new }

  describe "#list" do
    before do
      allow(Pike13::Desk::Invoice).to receive(:all)
        .and_return([{ id: 1, invoice_number: "INV-001", total_amount: 150.00 }])
    end

    it "calls Invoice.all from the SDK" do
      expect(Pike13::Desk::Invoice).to receive(:all)

      command.invoke(:list)
    end

    it "outputs the invoices list" do
      expect { command.invoke(:list) }
        .to output(/INV-001/).to_stdout
    end
  end

  describe "#get" do
    let(:invoice_id) { "1" }

    before do
      allow(Pike13::Desk::Invoice).to receive(:find)
        .with(invoice_id)
        .and_return({ id: invoice_id, invoice_number: "INV-001", total_amount: 150.00 })
    end

    it "calls Invoice.find from the SDK" do
      expect(Pike13::Desk::Invoice).to receive(:find)
        .with(invoice_id)

      command.invoke(:get, [invoice_id])
    end

    it "outputs the invoice details" do
      expect { command.invoke(:get, [invoice_id]) }
        .to output(/150\.0/).to_stdout
    end
  end
end
