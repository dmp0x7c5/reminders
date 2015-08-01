module Skills
  class Toggle
    attr_accessor :reminder, :user, :skills_repo

    def initialize(reminder:, user:, skills_repo: nil)
      self.reminder = reminder
      self.user = user
      self.skills_repo = skills_repo || SkillsRepository.new
    end

    def call
      skill = skills_repo.find_for_reminder_and_user(reminder, user)
      if skill.present?
        skills_repo.delete(skill)
      else
        skills_repo.create(user_id: user.id, reminder_id: reminder.id)
      end
    end
  end
end
