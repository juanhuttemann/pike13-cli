# frozen_string_literal: true

RSpec.describe Pike13::CLI::Commands::Desk::EventOccurrenceVisit do
  let(:command) { described_class.new }
  let(:event_occurrence_id) { "123" }

  describe "#list" do
    before do
      allow(Pike13::Desk::EventOccurrenceVisit).to receive(:all)
        .with(event_occurrence_id: event_occurrence_id)
        .and_return([{ id: "456", person_name: "John Doe" }])
    end

    it "calls EventOccurrenceVisit.all from the SDK" do
      expect(Pike13::Desk::EventOccurrenceVisit).to receive(:all)
        .with(event_occurrence_id: event_occurrence_id)

      command.invoke(:list, [event_occurrence_id])
    end

    it "outputs the visits list" do
      expect { command.invoke(:list, [event_occurrence_id]) }
        .to output(/John Doe/).to_stdout
    end
  end
end
