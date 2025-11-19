# frozen_string_literal: true

RSpec.describe Pike13::CLI::Commands::Desk::Event do
  let(:command) { described_class.new }

  describe "#list" do
    let(:events_data) do
      [{ id: 1, name: "Yoga Class", event_type: "group_class", service_id: 123 }]
    end

    before do
      allow(Pike13::Desk::Event).to receive(:all)
        .and_return(events_data)
    end

    it "calls Event.all from the SDK" do
      expect(Pike13::Desk::Event).to receive(:all)

      command.invoke(:list)
    end

    it "outputs the events list" do
      expect { command.invoke(:list) }
        .to output(/Yoga Class/).to_stdout
    end

    context "with date parameters" do
      let(:from_date) { "2023-02-01" }
      let(:to_date) { "2023-02-28" }

      it "passes date parameters to Event.all" do
        expect(Pike13::Desk::Event).to receive(:all)
          .with(from: from_date, to: to_date)

        command.invoke(:list, [], { from: from_date, to: to_date })
      end
    end

    context "with ids parameter" do
      let(:ids) { "1,2,3" }

      it "passes ids parameter to Event.all" do
        expect(Pike13::Desk::Event).to receive(:all)
          .with(ids: ids)

        command.invoke(:list, [], { ids: ids })
      end
    end

    context "with service_ids parameter" do
      let(:service_ids) { "123,456" }

      it "passes service_ids parameter to Event.all" do
        expect(Pike13::Desk::Event).to receive(:all)
          .with(service_ids: service_ids)

        command.invoke(:list, [], { service_ids: service_ids })
      end
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
