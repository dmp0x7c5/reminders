require "rails_helper"

describe Reminders::Delete do
  let!(:reminders_repo) { InMemoryRepository.new }
  let!(:service) { described_class.new(reminder, reminders_repo) }
  let!(:reminder) { create(:reminder) }

  describe "#call" do
    it "calls delete on repo" do
      expect(reminders_repo).to receive(:delete).with(reminder)
      service.call
    end
  end
end
