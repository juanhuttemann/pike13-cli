# frozen_string_literal: true

RSpec.describe Pike13::CLI::Commands::Desk::EventOccurrenceNote do
  let(:command) { described_class.new }
  let(:event_occurrence_id) { "123" }
  let(:note_id) { "456" }

  describe "#list" do
    before do
      allow(Pike13::Desk::EventOccurrenceNote).to receive(:all)
        .with(event_occurrence_id: event_occurrence_id)
        .and_return([{ id: note_id, note: "Test note" }])
    end

    it "calls EventOccurrenceNote.all from the SDK" do
      expect(Pike13::Desk::EventOccurrenceNote).to receive(:all)
        .with(event_occurrence_id: event_occurrence_id)

      command.invoke(:list, [event_occurrence_id])
    end

    it "outputs the notes list" do
      expect { command.invoke(:list, [event_occurrence_id]) }
        .to output(/Test note/).to_stdout
    end
  end

  describe "#get" do
    before do
      allow(Pike13::Desk::EventOccurrenceNote).to receive(:find)
        .with(event_occurrence_id: event_occurrence_id, id: note_id)
        .and_return({ id: note_id, note: "Specific note" })
    end

    it "calls EventOccurrenceNote.find from the SDK" do
      expect(Pike13::Desk::EventOccurrenceNote).to receive(:find)
        .with(event_occurrence_id: event_occurrence_id, id: note_id)

      command.invoke(:get, [event_occurrence_id, note_id])
    end

    it "outputs the specific note" do
      expect { command.invoke(:get, [event_occurrence_id, note_id]) }
        .to output(/Specific note/).to_stdout
    end
  end

  describe "#create" do
    let(:note_content) { "New note content" }
    let(:note_subject) { "Note subject" }

    before do
      allow(Pike13::Desk::EventOccurrenceNote).to receive(:create)
        .with(event_occurrence_id: event_occurrence_id, attributes: { note: note_content, subject: note_subject })
        .and_return({ id: note_id, note: note_content, subject: note_subject })
    end

    it "calls EventOccurrenceNote.create from the SDK" do
      expect(Pike13::Desk::EventOccurrenceNote).to receive(:create)
        .with(event_occurrence_id: event_occurrence_id, attributes: { note: note_content, subject: note_subject })

      command.invoke(:create, [event_occurrence_id], { note: note_content, subject: note_subject })
    end

    it "outputs the created note" do
      expect { command.invoke(:create, [event_occurrence_id], { note: note_content, subject: note_subject }) }
        .to output(/New note content/).to_stdout
    end
  end

  describe "#update" do
    let(:updated_note) { "Updated note content" }

    before do
      allow(Pike13::Desk::EventOccurrenceNote).to receive(:update)
        .with(event_occurrence_id: event_occurrence_id, id: note_id, attributes: { note: updated_note })
        .and_return({ id: note_id, note: updated_note })
    end

    it "calls EventOccurrenceNote.update from the SDK" do
      expect(Pike13::Desk::EventOccurrenceNote).to receive(:update)
        .with(event_occurrence_id: event_occurrence_id, id: note_id, attributes: { note: updated_note })

      command.invoke(:update, [event_occurrence_id, note_id], { note: updated_note })
    end

    it "outputs the updated note" do
      expect { command.invoke(:update, [event_occurrence_id, note_id], { note: updated_note }) }
        .to output(/Updated note content/).to_stdout
    end
  end

  describe "#delete" do
    before do
      allow(Pike13::Desk::EventOccurrenceNote).to receive(:destroy)
        .with(event_occurrence_id: event_occurrence_id, id: note_id)
        .and_return({ deleted: true })
    end

    it "calls EventOccurrenceNote.destroy from the SDK" do
      expect(Pike13::Desk::EventOccurrenceNote).to receive(:destroy)
        .with(event_occurrence_id: event_occurrence_id, id: note_id)

      command.invoke(:delete, [event_occurrence_id, note_id])
    end

    it "outputs the deletion result" do
      expect { command.invoke(:delete, [event_occurrence_id, note_id]) }
        .to output(/deleted/).to_stdout
    end
  end
end
