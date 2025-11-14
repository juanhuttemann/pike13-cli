# frozen_string_literal: true

RSpec.describe Pike13::CLI::Commands::Account::Confirmation do
  let(:command) { described_class.new }

  describe "#create" do
    let(:confirmation_token) { "test_confirmation_token_123" }

    context "when confirmation token is valid" do
      before do
        allow(Pike13::Account::Confirmation).to receive(:create)
          .with(confirmation_token: confirmation_token)
          .and_return({ status: "confirmed", message: "Email confirmed successfully" })
      end

      it "creates confirmation with provided token" do
        expect(Pike13::Account::Confirmation).to receive(:create)
          .with(confirmation_token: confirmation_token)

        command.invoke(:create, [], { token: confirmation_token })
      end

      it "outputs successful confirmation result" do
        allow(Pike13::Account::Confirmation).to receive(:create)
          .with(confirmation_token: confirmation_token)
          .and_return({ status: "confirmed", message: "Email confirmed successfully" })

        expect { command.invoke(:create, [], { token: confirmation_token }) }
          .to output(/Email confirmed successfully/).to_stdout
      end
    end

    context "when confirmation token is invalid" do
      before do
        allow(Pike13::Account::Confirmation).to receive(:create)
          .and_raise(Pike13::ValidationError.new("Invalid confirmation token"))
      end

      it "handles validation error gracefully" do
        expect(command).to receive(:handle_error).and_yield

        command.invoke(:create, [], { token: "invalid_token" })
      end
    end
  end
end
