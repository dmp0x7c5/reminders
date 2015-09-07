class UsersWithSkillRepository
  attr_accessor :reminder

  def initialize(reminder)
    self.reminder = reminder
  end

  def all
    User.joins(:skills)
      .where(skills: { reminder_id: reminder.id })
      .where(paused: false)
  end
end
