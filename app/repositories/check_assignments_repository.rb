class CheckAssignmentsRepository
  def latest_assignment(project_check)
    project_check.check_assignments.first
  end

  def add(parameters)
    CheckAssignment.create(parameters)
  end

  def update(assignment, parameters)
    assignment.update_attributes(parameters)
    assignment
  end
end
