# frozen_string_literal: true

RSpec.describe Pike13::CLI::Commands::Desk::Punch do
  let(:command) { described_class.new }
  let(:punch_id) { "456" }

  describe "#get" do
    before do
      allow(Pike13::Desk::Punch).to receive(:find)
        .with(punch_id)
        .and_return({ id: punch_id, used_count: 3, total_count: 10 })
    end

    it "calls Punch.find from the SDK" do
      expect(Pike13::Desk::Punch).to receive(:find)
        .with(punch_id)

      command.invoke(:get, [punch_id])
    end

    it "outputs the punch details" do
      expect { command.invoke(:get, [punch_id]) }
        .to output(/3/).to_stdout
    end
  end
end
