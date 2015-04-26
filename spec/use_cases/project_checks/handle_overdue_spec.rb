require "spec_helper"

describe ProjectChecks::HandleOverdue do
  let(:service) {  described_class.new(check, days_diff, notifier) }
  let(:days_diff) { 10 }
  let(:project) { double(:project, name: "foo project") }
  let(:reminder) { double(:reminder, name: "bar baz", valid_for_n_days: 5) }
  let(:check) { double(:project_check, reminder: reminder, project: project) }
  let(:notifier) { double(:notifier, send_message: true) }

  describe "#call" do
    it "passes message to notifier" do
      expect(notifier).to receive(:send_message)
      service.call
    end
  end
end
