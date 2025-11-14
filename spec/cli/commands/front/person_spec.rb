# frozen_string_literal: true

RSpec.describe Pike13::CLI::Commands::Front::Person do
  let(:command) { described_class.new }

  describe "#me" do
    before do
      allow(Pike13::Front::Person).to receive(:me)
        .and_return({ id: 123, full_name: "Client User", email: "client@example.com" })
    end

    it "calls Person.me from the SDK" do
      expect(Pike13::Front::Person).to receive(:me)

      command.invoke(:me)
    end

    it "outputs the current user details" do
      expect { command.invoke(:me) }
        .to output(/Client User/).to_stdout
    end
  end
end
