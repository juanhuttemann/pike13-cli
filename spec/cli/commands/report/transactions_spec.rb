# frozen_string_literal: true

RSpec.describe Pike13::CLI::Commands::Report::Transactions do
  let(:command) { described_class.new }

  describe "#query" do
    let(:query_params) do
      {
        fields: %w[transaction_id transaction_date net_paid_amount payment_method],
        filter: %w[eq payment_method creditcard]
      }
    end

    before do
      allow(Pike13::Reporting::Transactions).to receive(:query)
        .with(query_params)
        .and_return([{ transaction_id: 123, transaction_date: "2024-01-15", net_paid_amount: 100.00,
                       payment_method: "creditcard" }])
    end

    it "calls Transactions.query from the SDK" do
      expect(Pike13::Reporting::Transactions).to receive(:query)
        .with(query_params)

      command.invoke(:query, [], query_params)
    end

    it "outputs the transaction data" do
      expect { command.invoke(:query, [], query_params) }
        .to output(/100\.0/).to_stdout
    end
  end
end
