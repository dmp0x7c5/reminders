require "rails_helper"

describe PendingCheckAssignmentsReminderJob do
  include RepositoriesHelpers

  let(:job) { described_class.new(project_check.id) }
  let(:project_checks_repository) { create_repository(project_check) }
  let(:check_assignment) do
    double(:check_assignment,
           id: 1, user_id: 1, project_check_id: 1, completion_date: nil,
           created_at: nil
          )
  end

  let(:project_check) do
    double(:project_check, id: 1, created_at: Time.current, reminder_id: 1)
  end
  describe "#perform" do
    before do
      job.project_checks_repository = project_checks_repository
    end

    after do
      job.perform
    end

    let(:check_assignments_repository) { create_repository }

    it "calls reminging service" do
      expect(CheckAssignments::RemindPendingCheckAssignment)
        .to receive_message_chain(:new, :call)
    end
  end
end
