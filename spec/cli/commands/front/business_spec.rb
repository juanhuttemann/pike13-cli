# frozen_string_literal: true

RSpec.describe Pike13::CLI::Commands::Front::Business do
  let(:command) { described_class.new }

  describe "#show" do
    before do
      allow(Pike13::Front::Business).to receive(:find)
        .and_return({ id: 1, name: "Client Business", description: "Public business info" })
    end

    it "calls Business.find from the SDK" do
      expect(Pike13::Front::Business).to receive(:find)

      command.invoke(:show)
    end

    it "outputs the business details" do
      expect { command.invoke(:show) }
        .to output(/Client Business/).to_stdout
    end
  end
end
