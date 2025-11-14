# frozen_string_literal: true

RSpec.describe Pike13::CLI::Commands::Front::Location do
  let(:command) { described_class.new }

  describe "#list" do
    before do
      allow(Pike13::Front::Location).to receive(:all)
        .and_return([{ id: 1, name: "Main Studio", address: "123 Main St" }])
    end

    it "calls Location.all from the SDK" do
      expect(Pike13::Front::Location).to receive(:all)

      command.invoke(:list)
    end

    it "outputs the locations list" do
      expect { command.invoke(:list) }
        .to output(/Main Studio/).to_stdout
    end
  end
end
