require "rails_helper"
require "json"

describe UsersWithSkillRepository do
  let(:reminder) { create(:reminder) }
  let(:repo) { described_class.new(reminder) }

  describe "#all" do
    before do
      2.times do
        user = create(:user)
        create(:skill, user_id: user.id, reminder_id: reminder.id)
      end

      2.times { create(:user) }
    end

    it "returns all users with skills" do
      expect(repo.all.count).to eq 2
      repo.all.each do |user|
        expect(user.skills).to_not be_empty
      end
    end
  end

  describe "#active" do
    let(:user) { create(:user) }
    let(:user_without_skills) { create(:user) }
    let(:archived_user) { create(:user, archived_at: Time.current) }

    before do
      create(:skill, user_id: user.id, reminder_id: reminder.id)
      create(:skill, user_id: archived_user.id, reminder_id: reminder.id)
    end

    it "return only not archived users" do
      expect(repo.active.count).to eq(1)
      expect(repo.active.first.to_json).to eq(user.to_json)
    end
  end
end
