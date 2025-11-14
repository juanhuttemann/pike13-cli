# frozen_string_literal: true

RSpec.describe Pike13::CLI::Commands::Front::Service do
  let(:command) { described_class.new }

  describe "#list" do
    before do
      allow(Pike13::Front::Service).to receive(:all)
        .and_return([{ id: 1, name: "Yoga Classes", description: "Public yoga classes" }])
    end

    it "calls Service.all from the SDK" do
      expect(Pike13::Front::Service).to receive(:all)

      command.invoke(:list)
    end

    it "outputs the services list" do
      expect { command.invoke(:list) }
        .to output(/Yoga Classes/).to_stdout
    end
  end
end
