# frozen_string_literal: true

RSpec.describe Pike13::CLI::Commands::Desk::PersonVisit do
  let(:command) { described_class.new }
  let(:person_id) { "123" }

  describe "#list" do
    let(:visits_data) do
      [{
        id: 1,
        person_id: person_id,
        event_occurrence_id: 456,
        state: "registered",
        status: "incomplete",
        registered_at: "2023-01-23T23:38:08Z",
        event_occurrence: {
          id: 456,
          name: "Guitar Lessons",
          start_at: "2023-02-07T01:00:00Z"
        }
      }]
    end

    before do
      allow(Pike13::Desk::PersonVisit).to receive(:all)
        .and_return(visits_data)
    end

    it "calls PersonVisit.all with person_id" do
      expect(Pike13::Desk::PersonVisit).to receive(:all)
        .with(person_id: person_id)

      command.invoke(:list, [person_id])
    end

    it "outputs the visits list" do
      expect { command.invoke(:list, [person_id]) }
        .to output(/Guitar Lessons/).to_stdout
    end

    context "with date parameters" do
      let(:from_date) { "2023-02-01" }
      let(:to_date) { "2023-02-28" }

      it "passes date parameters to PersonVisit.all" do
        expect(Pike13::Desk::PersonVisit).to receive(:all)
          .with(person_id: person_id, from: from_date, to: to_date)

        command.invoke(:list, [person_id], { from: from_date, to: to_date })
      end
    end

    context "with event_occurrence_id parameter" do
      let(:event_occurrence_id) { "456" }

      it "passes event_occurrence_id to PersonVisit.all" do
        expect(Pike13::Desk::PersonVisit).to receive(:all)
          .with(person_id: person_id, event_occurrence_id: event_occurrence_id)

        command.invoke(:list, [person_id], { event_occurrence_id: event_occurrence_id })
      end
    end
  end
end
