# frozen_string_literal: true

RSpec.describe Pike13::CLI::Commands::Front::PlanTerms do
  let(:command) { described_class.new }
  let(:plan_id) { "123" }
  let(:terms_id) { "456" }

  describe "#list" do
    before do
      allow(Pike13::Front::PlanTerms).to receive(:all)
        .with(plan_id: plan_id)
        .and_return([{ id: terms_id, plan_id: plan_id, status: "active" }])
    end

    it "calls PlanTerms.all from the SDK" do
      expect(Pike13::Front::PlanTerms).to receive(:all)
        .with(plan_id: plan_id)

      command.invoke(:list, [plan_id])
    end

    it "outputs the plan terms list" do
      expect { command.invoke(:list, [plan_id]) }
        .to output(/active/).to_stdout
    end
  end

  describe "#get" do
    before do
      allow(Pike13::Front::PlanTerms).to receive(:find)
        .with(plan_id: plan_id, plan_terms_id: terms_id)
        .and_return({ id: terms_id, plan_id: plan_id, status: "pending" })
    end

    it "calls PlanTerms.find from the SDK" do
      expect(Pike13::Front::PlanTerms).to receive(:find)
        .with(plan_id: plan_id, plan_terms_id: terms_id)

      command.invoke(:get, [plan_id, terms_id])
    end

    it "outputs the specific plan terms" do
      expect { command.invoke(:get, [plan_id, terms_id]) }
        .to output(/pending/).to_stdout
    end
  end

  describe "#complete" do
    before do
      allow(Pike13::Front::PlanTerms).to receive(:complete)
        .with(plan_id: plan_id, plan_terms_id: terms_id)
        .and_return({ id: terms_id, plan_id: plan_id, status: "completed" })
    end

    it "calls PlanTerms.complete from the SDK" do
      expect(Pike13::Front::PlanTerms).to receive(:complete)
        .with(plan_id: plan_id, plan_terms_id: terms_id)

      command.invoke(:complete, [plan_id, terms_id])
    end

    it "outputs the completion result" do
      expect { command.invoke(:complete, [plan_id, terms_id]) }
        .to output(/completed/).to_stdout
    end
  end
end
