# frozen_string_literal: true

RSpec.describe Pike13::CLI::Commands::Desk::EventOccurrenceWaitlistEntry do
  let(:command) { described_class.new }
  let(:event_occurrence_id) { "123" }

  describe "#list" do
    before do
      allow(Pike13::Desk::EventOccurrenceWaitlistEntry).to receive(:all)
        .with(event_occurrence_id: event_occurrence_id)
        .and_return([{ id: "456", person_name: "Jane Smith" }])
    end

    it "calls EventOccurrenceWaitlistEntry.all from the SDK" do
      expect(Pike13::Desk::EventOccurrenceWaitlistEntry).to receive(:all)
        .with(event_occurrence_id: event_occurrence_id)

      command.invoke(:list, [event_occurrence_id])
    end

    it "outputs the waitlist entries list" do
      expect { command.invoke(:list, [event_occurrence_id]) }
        .to output(/Jane Smith/).to_stdout
    end
  end
end
