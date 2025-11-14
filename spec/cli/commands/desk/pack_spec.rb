# frozen_string_literal: true

RSpec.describe Pike13::CLI::Commands::Desk::Pack do
  let(:command) { described_class.new }
  let(:pack_id) { "123" }

  describe "#get" do
    before do
      allow(Pike13::Desk::Pack).to receive(:find)
        .with(pack_id)
        .and_return({ id: pack_id, name: "Test Pack", remaining_visits: 5 })
    end

    it "calls Pack.find from the SDK" do
      expect(Pike13::Desk::Pack).to receive(:find)
        .with(pack_id)

      command.invoke(:get, [pack_id])
    end

    it "outputs the pack details" do
      expect { command.invoke(:get, [pack_id]) }
        .to output(/Test Pack/).to_stdout
    end
  end
end
