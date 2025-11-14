# frozen_string_literal: true

RSpec.describe Pike13::CLI::Commands::Desk::Location do
  let(:command) { described_class.new }

  describe "#list" do
    before do
      allow(Pike13::Desk::Location).to receive(:all)
        .and_return([{ id: 1, name: "Main Studio", address: "123 Main St" }])
    end

    it "calls Location.all from the SDK" do
      expect(Pike13::Desk::Location).to receive(:all)

      command.invoke(:list)
    end

    it "outputs the locations list" do
      expect { command.invoke(:list) }
        .to output(/Main Studio/).to_stdout
    end
  end

  describe "#get" do
    let(:location_id) { "1" }

    before do
      allow(Pike13::Desk::Location).to receive(:find)
        .with(location_id)
        .and_return({ id: location_id, name: "Main Studio", address: "123 Main St" })
    end

    it "calls Location.find from the SDK" do
      expect(Pike13::Desk::Location).to receive(:find)
        .with(location_id)

      command.invoke(:get, [location_id])
    end

    it "outputs the location details" do
      expect { command.invoke(:get, [location_id]) }
        .to output(/Main Studio/).to_stdout
    end
  end
end
