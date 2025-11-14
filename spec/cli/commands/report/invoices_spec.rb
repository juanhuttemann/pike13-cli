# frozen_string_literal: true

RSpec.describe Pike13::CLI::Commands::Report::Invoices do
  let(:command) { described_class.new }

  describe "#query" do
    let(:query_params) do
      {
        fields: %w[invoice_id invoice_number total_amount outstanding_amount],
        filter: ["gt", "outstanding_amount", 0]
      }
    end

    before do
      allow(Pike13::Reporting::Invoices).to receive(:query)
        .with(query_params)
        .and_return([{ invoice_id: 1, invoice_number: "INV-001", total_amount: 200.00, outstanding_amount: 50.00 }])
    end

    it "calls Invoices.query from the SDK" do
      expect(Pike13::Reporting::Invoices).to receive(:query)
        .with(query_params)

      command.invoke(:query, [], query_params)
    end

    it "outputs the invoice data" do
      expect { command.invoke(:query, [], query_params) }
        .to output(/INV-001/).to_stdout
    end
  end
end
