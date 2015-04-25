class ProjectChecksRepository
  def all
    ProjectCheck.all
  end

  def for_reminder(reminder)
    all.includes(:project, :reminder)
      .where(reminder_id: reminder.id)
      .order("projects.name")
  end

  def create(reminder)
    persist reminder
  end

  def persist(reminder)
    reminder.save
  end

  def find(id)
    all.find_by_id id
  end
end
