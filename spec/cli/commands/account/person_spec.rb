# frozen_string_literal: true

RSpec.describe Pike13::CLI::Commands::Account::Person do
  let(:command) { described_class.new }

  describe "#list" do
    before do
      allow(Pike13::Account::Person).to receive(:all)
        .and_return([{ id: 123, full_name: "John Doe", email: "john@example.com" }])
    end

    it "calls Person.all from the SDK" do
      expect(Pike13::Account::Person).to receive(:all)

      command.invoke(:list)
    end

    it "outputs the people list" do
      expect { command.invoke(:list) }
        .to output(/John Doe/).to_stdout
    end
  end
end
