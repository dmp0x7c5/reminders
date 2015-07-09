class ProjectsRepository
  def all
    Project.all
  end

  def find(project_id)
    Project.find_by(id: project_id)
  end

  def with_done_checks
    Project.includes(checked_reviews: [:reminder, :last_check_user])
  end

  def persist(entity)
    entity.save
  end

  def for_reminder(reminder)
    reminder.projects
  end

  def for_reminder_with_checks(reminder)
    reminder.projects
      .includes(project_checks: [:reminder, :last_check_user])
      .distinct
  end

  def update(project, update_params)
    project.update_attributes(update_params)
  end

  delegate :find_by_name, to: :all
end
