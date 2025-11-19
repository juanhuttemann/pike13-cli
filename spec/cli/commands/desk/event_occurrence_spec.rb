# frozen_string_literal: true

RSpec.describe Pike13::CLI::Commands::Desk::EventOccurrence do
  let(:command) { described_class.new }

  describe "#list" do
    let(:event_occurrences_data) do
      [{
        id: 1,
        name: "Guitar Lessons",
        service_id: 123,
        location_id: 456,
        start_at: "2023-02-07T01:00:00Z",
        state: "active"
      }]
    end

    before do
      allow(Pike13::Desk::EventOccurrence).to receive(:all)
        .and_return(event_occurrences_data)
    end

    it "calls EventOccurrence.all from the SDK" do
      expect(Pike13::Desk::EventOccurrence).to receive(:all)

      command.invoke(:list)
    end

    it "outputs the event occurrences list" do
      expect { command.invoke(:list) }
        .to output(/Guitar Lessons/).to_stdout
    end

    context "with date parameters" do
      let(:from_date) { "2023-02-01" }
      let(:to_date) { "2023-02-28" }

      it "passes date parameters to EventOccurrence.all" do
        expect(Pike13::Desk::EventOccurrence).to receive(:all)
          .with(from: from_date, to: to_date)

        command.invoke(:list, [], { from: from_date, to: to_date })
      end
    end

    context "with state parameter" do
      let(:state) { "active" }

      it "passes state parameter to EventOccurrence.all" do
        expect(Pike13::Desk::EventOccurrence).to receive(:all)
          .with(state: state)

        command.invoke(:list, [], { state: state })
      end
    end

    context "with service_ids parameter" do
      let(:service_ids) { "123,456" }

      it "passes service_ids parameter to EventOccurrence.all" do
        expect(Pike13::Desk::EventOccurrence).to receive(:all)
          .with(service_ids: service_ids)

        command.invoke(:list, [], { service_ids: service_ids })
      end
    end

    context "with event_ids parameter" do
      let(:event_ids) { "789,101" }

      it "passes event_ids parameter to EventOccurrence.all" do
        expect(Pike13::Desk::EventOccurrence).to receive(:all)
          .with(event_ids: event_ids)

        command.invoke(:list, [], { event_ids: event_ids })
      end
    end

    context "with staff_member_ids parameter" do
      let(:staff_member_ids) { "111,222" }

      it "passes staff_member_ids parameter to EventOccurrence.all" do
        expect(Pike13::Desk::EventOccurrence).to receive(:all)
          .with(staff_member_ids: staff_member_ids)

        command.invoke(:list, [], { staff_member_ids: staff_member_ids })
      end
    end

    context "with location_ids parameter" do
      let(:location_ids) { "456,789" }

      it "passes location_ids parameter to EventOccurrence.all" do
        expect(Pike13::Desk::EventOccurrence).to receive(:all)
          .with(location_ids: location_ids)

        command.invoke(:list, [], { location_ids: location_ids })
      end
    end

    context "with group_by parameter" do
      let(:group_by) { "day" }

      it "passes group_by parameter to EventOccurrence.all" do
        expect(Pike13::Desk::EventOccurrence).to receive(:all)
          .with(group_by: group_by)

        command.invoke(:list, [], { group_by: group_by })
      end
    end
  end

  describe "#eligibilities" do
    let(:event_occurrence_id) { "123" }
    let(:eligibilities_data) do
      [{
        person_id: 456,
        can_enroll: true,
        restrictions: []
      }]
    end

    before do
      allow(Pike13::Desk::EventOccurrence).to receive(:enrollment_eligibilities)
        .and_return(eligibilities_data)
    end

    it "calls enrollment_eligibilities with event_occurrence_id" do
      expect(Pike13::Desk::EventOccurrence).to receive(:enrollment_eligibilities)
        .with(id: event_occurrence_id)

      command.invoke(:eligibilities, [event_occurrence_id])
    end

    context "with person_ids parameter" do
      let(:person_ids) { "456,789" }

      it "passes person_ids to enrollment_eligibilities" do
        expect(Pike13::Desk::EventOccurrence).to receive(:enrollment_eligibilities)
          .with(id: event_occurrence_id, person_ids: person_ids)

        command.invoke(:eligibilities, [event_occurrence_id], { person_ids: person_ids })
      end
    end
  end
end
