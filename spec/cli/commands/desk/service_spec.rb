# frozen_string_literal: true

RSpec.describe Pike13::CLI::Commands::Desk::Service do
  let(:command) { described_class.new }

  describe "#list" do
    before do
      allow(Pike13::Desk::Service).to receive(:all)
        .and_return([{ id: 1, name: "Personal Training", service_type: "appointment" }])
    end

    it "calls Service.all from the SDK" do
      expect(Pike13::Desk::Service).to receive(:all)

      command.invoke(:list)
    end

    it "outputs the services list" do
      expect { command.invoke(:list) }
        .to output(/Personal Training/).to_stdout
    end
  end

  describe "#get" do
    let(:service_id) { "1" }

    before do
      allow(Pike13::Desk::Service).to receive(:find)
        .with(service_id)
        .and_return({ id: service_id, name: "Personal Training", service_type: "appointment" })
    end

    it "calls Service.find from the SDK" do
      expect(Pike13::Desk::Service).to receive(:find)
        .with(service_id)

      command.invoke(:get, [service_id])
    end

    it "outputs the service details" do
      expect { command.invoke(:get, [service_id]) }
        .to output(/Personal Training/).to_stdout
    end
  end
end
