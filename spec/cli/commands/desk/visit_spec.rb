# frozen_string_literal: true

RSpec.describe Pike13::CLI::Commands::Desk::Visit do
  let(:command) { described_class.new }

  describe "#get" do
    let(:visit_id) { "1" }

    before do
      allow(Pike13::Desk::Visit).to receive(:find)
        .with(visit_id)
        .and_return({ id: visit_id, person_name: "John Client", visit_date: "2024-01-15" })
    end

    it "calls Visit.find from the SDK" do
      expect(Pike13::Desk::Visit).to receive(:find)
        .with(visit_id)

      command.invoke(:get, [visit_id])
    end

    it "outputs the visit details" do
      expect { command.invoke(:get, [visit_id]) }
        .to output(/John Client/).to_stdout
    end
  end

  describe "#summary" do
    let(:person_id) { "123" }

    before do
      allow(Pike13::Desk::Visit).to receive(:summary)
        .with(person_id: person_id)
        .and_return({ total_visits: 10, last_visit: "2024-01-15" })
    end

    it "calls Visit.summary from the SDK" do
      expect(Pike13::Desk::Visit).to receive(:summary)
        .with(person_id: person_id)

      command.invoke(:summary, [], { person_id: person_id })
    end

    it "outputs the visit summary" do
      expect { command.invoke(:summary, [], { person_id: person_id }) }
        .to output(/10/).to_stdout
    end
  end
end
