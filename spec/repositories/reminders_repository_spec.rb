require "rails_helper"

describe RemindersRepository do
  let(:repo) { described_class.new }

  describe "#all" do
    before do
      2.times { Reminder.create!(name: "test") }
    end

    it "returns all the reminders" do
      expect(repo.all.count).to eq 2
    end
  end

  describe "#create" do
    it "saves object" do
      reminder = Reminder.new(name: "test")
      repo.create reminder
      expect(reminder.persisted?).to eq true
    end
  end

  describe "#update" do
    let!(:reminder) { Reminder.create!(name: "foo") }

    it "updates object" do
      reminder.name = "bar"
      repo.update reminder
      expect(repo.find(reminder.id).name).to eq "bar"
    end
  end

  describe "#delete" do
    let!(:reminder) { Reminder.create!(name: "foo") }

    it "removes object from db" do
      repo.delete reminder
      expect(repo.find(reminder.id)).to eq nil
    end
  end
end
