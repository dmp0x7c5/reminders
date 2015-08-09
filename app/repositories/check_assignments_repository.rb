class CheckAssignmentsRepository
  def all
    CheckAssignment.all
  end

  def latest_assignment(project_check, completed: false)
    query = all.where(project_check_id: project_check.id)
    if completed
      query.where("completion_date IS NOT NULL").order("completion_date ASC")
    else
      query
    end.last
  end

  def add(parameters)
    CheckAssignment.create(parameters)
  end

  def delete(assignment_id)
    all.find(assignment_id).destroy
  end

  def update(assignment, parameters)
    assignment.update_attributes(parameters)
    assignment
  end
end
