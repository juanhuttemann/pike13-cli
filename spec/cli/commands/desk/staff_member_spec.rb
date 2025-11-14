# frozen_string_literal: true

RSpec.describe Pike13::CLI::Commands::Desk::StaffMember do
  let(:command) { described_class.new }

  describe "#list" do
    before do
      allow(Pike13::Desk::StaffMember).to receive(:all)
        .and_return([{ id: 1, full_name: "Trainer John", role: "trainer" }])
    end

    it "calls StaffMember.all from the SDK" do
      expect(Pike13::Desk::StaffMember).to receive(:all)

      command.invoke(:list)
    end

    it "outputs the staff members list" do
      expect { command.invoke(:list) }
        .to output(/Trainer John/).to_stdout
    end
  end

  describe "#get" do
    let(:staff_id) { "1" }

    before do
      allow(Pike13::Desk::StaffMember).to receive(:find)
        .with(staff_id)
        .and_return({ id: staff_id, full_name: "Trainer John", role: "trainer" })
    end

    it "calls StaffMember.find from the SDK" do
      expect(Pike13::Desk::StaffMember).to receive(:find)
        .with(staff_id)

      command.invoke(:get, [staff_id])
    end

    it "outputs the staff member details" do
      expect { command.invoke(:get, [staff_id]) }
        .to output(/Trainer John/).to_stdout
    end
  end

  describe "#me" do
    before do
      allow(Pike13::Desk::StaffMember).to receive(:me)
        .and_return({ id: 1, full_name: "Current Staff", role: "manager" })
    end

    it "calls StaffMember.me from the SDK" do
      expect(Pike13::Desk::StaffMember).to receive(:me)

      command.invoke(:me)
    end

    it "outputs the current staff member details" do
      expect { command.invoke(:me) }
        .to output(/Current Staff/).to_stdout
    end
  end
end
