class SkillsRepository
  def all
    Skill.all
  end

  def user_skills(user)
    all.where(user_id: user.id)
  end

  def find_for_reminder_and_user(reminder, user)
    all.where(reminder_id: reminder.id, user_id: user.id).first
  end

  def create(attrs)
    Skill.create!(attrs)
  end

  def delete(skill)
    skill.destroy!
  end

  def user_ids_for_reminder(reminder)
    all.where(reminder_id: reminder.id).pluck(:user_id)
  end
end
