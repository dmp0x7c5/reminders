require "rails_helper"

describe CheckAssignments::PickPerson do
  let(:service) do
    described_class.new(latest_checker: user,
                        users_repository: users_repo,
                        reminder: reminder,
                        skills_repository: skills_repo,
                       )
  end
  let(:users_repo) { UsersRepository.new }
  let(:reminder) { double(:reminder, id: 10, name: "foo reminder") }

  let(:skills_repo) do
    class InMemorySkillsRepository < InMemoryRepository
      def user_ids_for_reminder(reminder)
        all.select { |s| s.reminder_id == reminder.id }.map(&:user_id)
      end
    end
    InMemorySkillsRepository.new
  end

  before do
    %w(Jake Hank).each do |name|
      create(:user, name: name)
    end
  end

  describe "#call" do
    let(:user) { create(:user, name: "Jane") }

    it "returns user who has a skill for it" do
      john = create(:user)
      user_with_skill = double(:skill, id: 1, user_id: john.id,
                                       reminder_id: reminder.id)
      skills_repo.all = [user_with_skill]
      expect(service.call).to eq john
    end

    it "raises error when there is no user to select from" do
      expect { service.call }.to raise_error(/no user/)
    end
  end
end
