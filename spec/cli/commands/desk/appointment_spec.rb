# frozen_string_literal: true

RSpec.describe Pike13::CLI::Commands::Desk::Appointment do
  let(:command) { described_class.new }

  describe "#find_available_slots" do
    let(:params) do
      {
        service_id: 1,
        date: "2024-01-15",
        location_ids: [1, 2],
        staff_member_ids: [3, 4]
      }
    end

    before do
      allow(Pike13::Desk::Appointment).to receive(:find_available_slots)
        .with(params)
        .and_return([{ start_time: "2024-01-15T10:00:00Z", end_time: "2024-01-15T11:00:00Z" }])
    end

    it "calls Appointment.find_available_slots from the SDK" do
      expect(Pike13::Desk::Appointment).to receive(:find_available_slots)
        .with(params)

      command.invoke(:find_available_slots, [], params)
    end

    it "outputs the available slots" do
      expect { command.invoke(:find_available_slots, [], params) }
        .to output(/10:00:00/).to_stdout
    end
  end

  describe "#available_slots_summary" do
    let(:params) do
      {
        service_id: 1,
        from: "2024-01-01",
        to: "2024-01-31",
        location_ids: [1, 2],
        staff_member_ids: [3, 4]
      }
    end

    before do
      allow(Pike13::Desk::Appointment).to receive(:available_slots_summary)
        .with(params)
        .and_return({ total_slots: 20, available_slots: 15 })
    end

    it "calls Appointment.available_slots_summary from the SDK" do
      expect(Pike13::Desk::Appointment).to receive(:available_slots_summary)
        .with(params)

      command.invoke(:available_slots_summary, [], params)
    end

    it "outputs the slots summary" do
      expect { command.invoke(:available_slots_summary, [], params) }
        .to output(/15/).to_stdout
    end
  end
end
