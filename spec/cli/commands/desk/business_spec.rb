# frozen_string_literal: true

RSpec.describe Pike13::CLI::Commands::Desk::Business do
  let(:command) { described_class.new }

  describe "#find" do
    context "when business details are available" do
      let(:business_data) do
        {
          id: 1,
          name: "Test Business",
          subdomain: "test-business",
          phone: "555-1234",
          email: "info@testbusiness.com"
        }
      end

      before do
        allow(Pike13::Desk::Business).to receive(:find)
          .and_return(business_data)
      end

      it "calls Business.find from the SDK" do
        expect(Pike13::Desk::Business).to receive(:find)

        command.invoke(:find)
      end

      it "outputs business details" do
        allow(Pike13::Desk::Business).to receive(:find)
          .and_return(business_data)

        expect { command.invoke(:find) }
          .to output(/Test Business/).to_stdout
      end
    end

    context "when business details are not available" do
      before do
        allow(Pike13::Desk::Business).to receive(:find)
          .and_raise(Pike13::NotFoundError.new("Business not found"))
      end

      it "handles not found error gracefully" do
        expect(command).to receive(:handle_error).and_yield

        command.invoke(:find)
      end
    end
  end
end
