class SkillsRepository
  def user_skills(user)
    Skill.where(user_id: user.id)
  end

  def find_for_reminder_and_user(reminder, user)
    Skill.where(reminder_id: reminder.id, user_id: user.id).first
  end

  def create(attrs)
    Skill.create!(attrs)
  end

  def delete(skill)
    skill.destroy!
  end
end
