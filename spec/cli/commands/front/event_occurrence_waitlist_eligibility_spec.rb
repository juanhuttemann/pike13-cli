# frozen_string_literal: true

RSpec.describe Pike13::CLI::Commands::Front::EventOccurrenceWaitlistEligibility do
  let(:command) { described_class.new }
  let(:event_occurrence_id) { "123" }

  describe "#list" do
    before do
      allow(Pike13::Front::EventOccurrenceWaitlistEligibility).to receive(:all)
        .with(event_occurrence_id: event_occurrence_id)
        .and_return([{ eligible: true, position: 1 }])
    end

    it "calls EventOccurrenceWaitlistEligibility.all from the SDK" do
      expect(Pike13::Front::EventOccurrenceWaitlistEligibility).to receive(:all)
        .with(event_occurrence_id: event_occurrence_id)

      command.invoke(:list, [event_occurrence_id])
    end

    it "outputs the eligibility list" do
      expect { command.invoke(:list, [event_occurrence_id]) }
        .to output(/eligible/).to_stdout
    end
  end
end
