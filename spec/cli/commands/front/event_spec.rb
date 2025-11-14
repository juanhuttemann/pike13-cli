# frozen_string_literal: true

RSpec.describe Pike13::CLI::Commands::Front::Event do
  let(:command) { described_class.new }

  describe "#list" do
    before do
      allow(Pike13::Front::Event).to receive(:all)
        .and_return([{ id: 1, name: "Public Yoga Class", event_type: "group_class" }])
    end

    it "calls Event.all from the SDK" do
      expect(Pike13::Front::Event).to receive(:all)

      command.invoke(:list)
    end

    it "outputs the events list" do
      expect { command.invoke(:list) }
        .to output(/Public Yoga Class/).to_stdout
    end
  end
end
