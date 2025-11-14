# frozen_string_literal: true

RSpec.describe Pike13::CLI::Commands::Account::Password do
  let(:command) { described_class.new }

  describe "#reset" do
    let(:email) { "test@example.com" }

    context "when email is valid" do
      before do
        allow(Pike13::Account::Password).to receive(:create)
          .with(email: email)
          .and_return({ status: "reset_sent", message: "Password reset email sent" })
      end

      it "creates password reset with provided email" do
        expect(Pike13::Account::Password).to receive(:create)
          .with(email: email)

        command.invoke(:reset, [], { email: email })
      end

      it "outputs successful reset result" do
        allow(Pike13::Account::Password).to receive(:create)
          .with(email: email)
          .and_return({ status: "reset_sent", message: "Password reset email sent" })

        expect { command.invoke(:reset, [], { email: email }) }
          .to output(/Password reset email sent/).to_stdout
      end
    end

    context "when email is invalid" do
      before do
        allow(Pike13::Account::Password).to receive(:create)
          .and_raise(Pike13::ValidationError.new("Invalid email address"))
      end

      it "handles validation error gracefully" do
        expect { command.invoke(:reset, [], { email: "invalid-email" }) }.to raise_error(SystemExit)
      end
    end
  end
end
