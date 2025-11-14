# frozen_string_literal: true

RSpec.describe Pike13::CLI::Commands::Desk::Note do
  let(:command) { described_class.new }
  let(:person_id) { "123" }
  let(:note_id) { "456" }

  describe "#list" do
    before do
      allow(Pike13::Desk::Note).to receive(:all)
        .with(person_id: person_id)
        .and_return([{ id: note_id, note: "Client note", created_at: "2024-01-15" }])
    end

    it "calls Note.all from the SDK" do
      expect(Pike13::Desk::Note).to receive(:all)
        .with(person_id: person_id)

      command.invoke(:list, [person_id])
    end

    it "outputs the notes list" do
      expect { command.invoke(:list, [person_id]) }
        .to output(/Client note/).to_stdout
    end
  end

  describe "#get" do
    before do
      allow(Pike13::Desk::Note).to receive(:find)
        .with(person_id: person_id, id: note_id)
        .and_return({ id: note_id, note: "Specific client note", created_at: "2024-01-15" })
    end

    it "calls Note.find from the SDK" do
      expect(Pike13::Desk::Note).to receive(:find)
        .with(person_id: person_id, id: note_id)

      command.invoke(:get, [person_id, note_id])
    end

    it "outputs the specific note" do
      expect { command.invoke(:get, [person_id, note_id]) }
        .to output(/Specific client note/).to_stdout
    end
  end

  describe "#create" do
    let(:attributes) do
      {
        note: "New client note",
        subject: "Note subject"
      }
    end

    before do
      allow(Pike13::Desk::Note).to receive(:create)
        .with(person_id: person_id, attributes: attributes)
        .and_return({ id: note_id, **attributes })
    end

    it "calls Note.create from the SDK" do
      expect(Pike13::Desk::Note).to receive(:create)
        .with(person_id: person_id, attributes: attributes)

      command.invoke(:create, [person_id], attributes)
    end

    it "outputs the created note" do
      expect { command.invoke(:create, [person_id], attributes) }
        .to output(/New client note/).to_stdout
    end
  end
end
