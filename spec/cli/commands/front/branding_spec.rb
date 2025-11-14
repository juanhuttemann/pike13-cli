# frozen_string_literal: true

RSpec.describe Pike13::CLI::Commands::Front::Branding do
  let(:command) { described_class.new }

  describe "#show" do
    before do
      allow(Pike13::Front::Branding).to receive(:find)
        .and_return({ id: 1, company_name: "Test Business", logo_url: "https://example.com/logo.png" })
    end

    it "calls Branding.find from the SDK" do
      expect(Pike13::Front::Branding).to receive(:find)

      command.invoke(:show)
    end

    it "outputs the branding details" do
      expect { command.invoke(:show) }
        .to output(/Test Business/).to_stdout
    end
  end
end
