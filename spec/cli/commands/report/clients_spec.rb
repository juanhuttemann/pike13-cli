# frozen_string_literal: true

RSpec.describe Pike13::CLI::Commands::Report::Clients do
  let(:command) { described_class.new }

  describe "#query" do
    let(:query_params) do
      {
        fields: %w[person_id full_name email],
        filter: ["eq", "has_membership", true]
      }
    end

    before do
      allow(Pike13::Reporting::Clients).to receive(:query)
        .with(query_params)
        .and_return([{ person_id: 123, full_name: "John Member", email: "john@example.com" }])
    end

    it "calls Clients.query from the SDK" do
      expect(Pike13::Reporting::Clients).to receive(:query)
        .with(query_params)

      command.invoke(:query, [], query_params)
    end

    it "outputs the client data" do
      expect { command.invoke(:query, [], query_params) }
        .to output(/John Member/).to_stdout
    end
  end
end
