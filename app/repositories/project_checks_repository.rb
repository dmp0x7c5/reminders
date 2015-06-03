class ProjectChecksRepository
  def all
    ProjectCheck.all.includes(:project)
  end

  def for_reminder(reminder)
    all.includes(:project, :reminder, :last_check_user)
      .where(reminder_id: reminder.id)
      .order("projects.name")
  end

  def add(reminder, project)
    ProjectCheck.create(project_id: project.id, reminder_id: reminder.id)
  end

  def create(entity)
    persist entity
  end

  def persist(entity)
    entity.save
  end

  def find(id)
    all.find_by_id id
  end
end
