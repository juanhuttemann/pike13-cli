# frozen_string_literal: true

RSpec.describe Pike13::CLI::Commands::Desk::Person do
  let(:command) { described_class.new }

  describe "#list" do
    before do
      allow(Pike13::Desk::Person).to receive(:all)
        .and_return([{ id: 123, full_name: "Jane Doe", email: "jane@example.com" }])
    end

    it "calls Person.all from the SDK" do
      expect(Pike13::Desk::Person).to receive(:all)

      command.invoke(:list)
    end

    it "outputs the people list" do
      expect { command.invoke(:list) }
        .to output(/Jane Doe/).to_stdout
    end
  end

  describe "#get" do
    let(:person_id) { "123" }

    before do
      allow(Pike13::Desk::Person).to receive(:find)
        .with(person_id)
        .and_return({ id: person_id, full_name: "Jane Doe", email: "jane@example.com" })
    end

    it "calls Person.find from the SDK" do
      expect(Pike13::Desk::Person).to receive(:find)
        .with(person_id)

      command.invoke(:get, [person_id])
    end

    it "outputs the person details" do
      expect { command.invoke(:get, [person_id]) }
        .to output(/Jane Doe/).to_stdout
    end
  end

  describe "#create" do
    let(:attributes) do
      {
        first_name: "John",
        last_name: "Smith",
        email: "john.smith@example.com"
      }
    end

    before do
      allow(Pike13::Desk::Person).to receive(:create)
        .with(attributes)
        .and_return({ id: 456, **attributes })
    end

    it "calls Person.create from the SDK" do
      expect(Pike13::Desk::Person).to receive(:create)
        .with(attributes)

      command.invoke(:create, [], attributes)
    end

    it "outputs the created person" do
      expect { command.invoke(:create, [], attributes) }
        .to output(/John/).to_stdout
    end
  end
end
