# frozen_string_literal: true

RSpec.describe Pike13::CLI::Commands::Front::EventOccurrenceNote do
  let(:command) { described_class.new }
  let(:event_occurrence_id) { "123" }
  let(:note_id) { "456" }

  describe "#list" do
    before do
      allow(Pike13::Front::EventOccurrenceNote).to receive(:all)
        .with(event_occurrence_id: event_occurrence_id)
        .and_return([{ id: note_id, note: "Client note" }])
    end

    it "calls EventOccurrenceNote.all from the SDK" do
      expect(Pike13::Front::EventOccurrenceNote).to receive(:all)
        .with(event_occurrence_id: event_occurrence_id)

      command.invoke(:list, [event_occurrence_id])
    end

    it "outputs the notes list" do
      expect { command.invoke(:list, [event_occurrence_id]) }
        .to output(/Client note/).to_stdout
    end
  end

  describe "#get" do
    before do
      allow(Pike13::Front::EventOccurrenceNote).to receive(:find)
        .with(event_occurrence_id: event_occurrence_id, id: note_id)
        .and_return({ id: note_id, note: "Specific client note" })
    end

    it "calls EventOccurrenceNote.find from the SDK" do
      expect(Pike13::Front::EventOccurrenceNote).to receive(:find)
        .with(event_occurrence_id: event_occurrence_id, id: note_id)

      command.invoke(:get, [event_occurrence_id, note_id])
    end

    it "outputs the specific note" do
      expect { command.invoke(:get, [event_occurrence_id, note_id]) }
        .to output(/Specific client note/).to_stdout
    end
  end
end
