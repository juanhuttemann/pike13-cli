# frozen_string_literal: true

RSpec.describe Pike13::CLI::Commands::Account::Business do
  let(:command) { described_class.new }

  describe "#list" do
    before do
      allow(Pike13::Account::Business).to receive(:all)
        .and_return([{ id: 1, name: "Test Business", subdomain: "test" }])
    end

    it "calls Business.all from the SDK" do
      expect(Pike13::Account::Business).to receive(:all)

      command.invoke(:list)
    end

    it "outputs the businesses list" do
      expect { command.invoke(:list) }
        .to output(/Test Business/).to_stdout
    end
  end
end
