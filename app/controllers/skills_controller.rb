class SkillsController < ApplicationController
  expose(:reminders_repo) { RemindersRepository.new }
  expose(:user_skills) { SkillsRepository.new.user_skills(current_user) }
  expose(:reminders_with_my_skills) do
    ReminderDecorator::WithSkill.decorate_collection(
      reminders_repo.all, context: { user_skills: user_skills })
  end

  def index
  end

  def toggle
    reminder = reminders_repo.find(params[:reminder_id])
    Skills::Toggle.new(reminder: reminder, user: current_user).call
    redirect_to skills_path, notice: "Skill toggled."
  end
end
