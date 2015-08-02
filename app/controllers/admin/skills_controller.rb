module Admin
  class SkillsController < AdminController
    expose(:user)
    expose(:reminders_repo) { RemindersRepository.new }
    expose(:user_skills) { SkillsRepository.new.user_skills(user) }
    expose(:reminders_with_my_skills) do
      ReminderDecorator::WithSkill.decorate_collection(
        reminders_repo.all, context: { user_skills: user_skills })
    end

    def index
    end

    def toggle
      reminder = reminders_repo.find(params[:reminder_id])
      Skills::Toggle.new(reminder: reminder, user: user).call
      redirect_to admin_user_skills_path(user), notice: "Skill toggled."
    end
  end
end
