# frozen_string_literal: true

RSpec.describe Pike13::CLI::Commands::Desk::Person do
  let(:command) { described_class.new }

  describe "#list" do
    let(:people_data) do
      [{ id: 123, full_name: "Jane Doe", email: "jane@example.com", is_member: true }]
    end

    before do
      allow(Pike13::Desk::Person).to receive(:all)
        .and_return(people_data)
    end

    it "calls Person.all from the SDK" do
      expect(Pike13::Desk::Person).to receive(:all)

      command.invoke(:list)
    end

    it "outputs the people list" do
      expect { command.invoke(:list) }
        .to output(/Jane Doe/).to_stdout
    end

    context "with is_member parameter" do
      it "passes is_member parameter to Person.all" do
        expect(Pike13::Desk::Person).to receive(:all)
          .with(is_member: true)

        command.invoke(:list, [], { is_member: true })
      end

      it "passes false is_member parameter" do
        expect(Pike13::Desk::Person).to receive(:all)
          .with(is_member: false)

        command.invoke(:list, [], { is_member: false })
      end
    end

    context "with sort parameter" do
      let(:sort_param) { "-updated_at" }

      it "passes sort parameter to Person.all" do
        expect(Pike13::Desk::Person).to receive(:all)
          .with(sort: sort_param)

        command.invoke(:list, [], { sort: sort_param })
      end
    end

    context "with timestamp parameters" do
      let(:created_since) { "2023-01-01T00:00:00Z" }
      let(:updated_since) { "2023-02-01T00:00:00Z" }

      it "passes timestamp parameters to Person.all" do
        expect(Pike13::Desk::Person).to receive(:all)
          .with(created_since: created_since, updated_since: updated_since)

        command.invoke(:list, [], { created_since: created_since, updated_since: updated_since })
      end
    end

    context "with include parameters" do
      it "passes include_relationships parameter" do
        expect(Pike13::Desk::Person).to receive(:all)
          .with(include_relationships: true)

        command.invoke(:list, [], { include_relationships: true })
      end

      it "passes include_balances parameter" do
        expect(Pike13::Desk::Person).to receive(:all)
          .with(include_balances: true)

        command.invoke(:list, [], { include_balances: true })
      end
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
