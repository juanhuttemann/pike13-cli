# frozen_string_literal: true

RSpec.describe Pike13::CLI::Commands::Desk::Booking do
  let(:command) { described_class.new }
  let(:booking_id) { "123" }

  describe "#get" do
    before do
      allow(Pike13::Desk::Booking).to receive(:find)
        .with(booking_id)
        .and_return({ id: booking_id, status: "confirmed", person_name: "John Client" })
    end

    it "calls Booking.find from the SDK" do
      expect(Pike13::Desk::Booking).to receive(:find)
        .with(booking_id)

      command.invoke(:get, [booking_id])
    end

    it "outputs the booking details" do
      expect { command.invoke(:get, [booking_id]) }
        .to output(/John Client/).to_stdout
    end
  end

  describe "#create" do
    let(:params) do
      {
        event_occurrence_id: 789,
        person_id: 123
      }
    end

    before do
      allow(Pike13::Desk::Booking).to receive(:create)
        .with(event_occurrence_id: params[:event_occurrence_id], person_id: params[:person_id], idempotency_token: kind_of(String))
        .and_return({ id: booking_id, status: "pending" })
    end

    it "calls Booking.create from the SDK" do
      expect(Pike13::Desk::Booking).to receive(:create)
        .with(event_occurrence_id: params[:event_occurrence_id], person_id: params[:person_id], idempotency_token: kind_of(String))

      command.invoke(:create, [], params)
    end

    it "outputs the created booking" do
      expect { command.invoke(:create, [], params) }
        .to output(/pending/).to_stdout
    end
  end
end
