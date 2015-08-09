class CheckAssignmentsRepository
  def all
    CheckAssignment.all
  end

  def latest_assignment(project_check)
    project_check.check_assignments.first
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
