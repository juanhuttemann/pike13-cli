# frozen_string_literal: true

RSpec.describe Pike13::CLI::Commands::Report::MonthlyBusinessMetrics do
  let(:command) { described_class.new }

  describe "#query" do
    let(:query_params) do
      {
        fields: %w[month_start_date net_paid_amount new_client_count],
        filter: %w[btw month_start_date 2024-01-01 2024-12-31]
      }
    end

    before do
      allow(Pike13::Reporting::MonthlyBusinessMetrics).to receive(:query)
        .with(query_params)
        .and_return([{ month_start_date: "2024-01-01", net_paid_amount: 5000.00, new_client_count: 10 }])
    end

    it "calls MonthlyBusinessMetrics.query from the SDK" do
      expect(Pike13::Reporting::MonthlyBusinessMetrics).to receive(:query)
        .with(query_params)

      command.invoke(:query, [], query_params)
    end

    it "outputs the metrics data" do
      expect { command.invoke(:query, [], query_params) }
        .to output(/5000\.0/).to_stdout
    end
  end
end
