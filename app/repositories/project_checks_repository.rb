class ProjectChecksRepository
  def all
    ProjectCheck.all
  end

  def for_reminder(reminder)
    all.includes(:project, :reminder, :last_check_user)
      .where(reminder_id: reminder.id)
      .order("projects.name")
  end

  def add(reminder, project)
    ProjectCheck.create(project_id: project.id, reminder_id: reminder.id)
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
