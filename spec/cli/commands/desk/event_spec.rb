# frozen_string_literal: true

RSpec.describe Pike13::CLI::Commands::Desk::Event do
  let(:command) { described_class.new }

  describe "#list" do
    before do
      allow(Pike13::Desk::Event).to receive(:all)
        .and_return([{ id: 1, name: "Yoga Class", event_type: "group_class" }])
    end

    it "calls Event.all from the SDK" do
      expect(Pike13::Desk::Event).to receive(:all)

      command.invoke(:list)
    end

    it "outputs the events list" do
      expect { command.invoke(:list) }
        .to output(/Yoga Class/).to_stdout
    end
  end

  describe "#get" do
    let(:event_id) { "1" }

    before do
      allow(Pike13::Desk::Event).to receive(:find)
        .with(event_id)
        .and_return({ id: event_id, name: "Yoga Class", event_type: "group_class" })
    end

    it "calls Event.find from the SDK" do
      expect(Pike13::Desk::Event).to receive(:find)
        .with(event_id)

      command.invoke(:get, [event_id])
    end

    it "outputs the event details" do
      expect { command.invoke(:get, [event_id]) }
        .to output(/Yoga Class/).to_stdout
    end
  end
end
