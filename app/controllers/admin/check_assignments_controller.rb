module Admin
  class CheckAssignmentsController < AdminController
    expose(:check_assignments_repo) { CheckAssignmentsRepository.new }

    def create
      if create_assignment.persisted?
        redirect_to history_project_check_path(params[:project_check_id]),
                    notice: "Manual entry added"
      else
        redirect_to history_project_check_path(params[:project_check_id]),
                    alert: "Sorry, can't save this entry. Check the params."
      end
    end

    private

    def create_assignment
      attrs = assignment_params.merge(
        project_check_id: params[:project_check_id],
      )
      check_assignments_repo.add(attrs)
    end

    def assignment_params
      params.require(:manual_check).permit(:completion_date, :user_id)
    end
  end
end
