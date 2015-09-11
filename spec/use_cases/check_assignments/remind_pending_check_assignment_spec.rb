require "rails_helper"

describe CheckAssignments::RemindPendingCheckAssignment do
  include RepositoriesHelpers

  let(:service) do
    described_class
      .new(project_check: project_check,
           check_assignments_repository: check_assignments_repository)
  end
  let(:user) { double(:user, id: 1, email: "john@doe.pl") }
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
      allow(check_assignments_repository).to receive(:latest_assignment) do
        check_assignments_repository.all.last
      end
    end

    after do
      service.call
    end

    context "when check has no one assigned" do
      let(:check_assignments_repository) { create_check_assignments_repository }

      it "doesn't send any reminder" do
        expect(UserReminderMailer).to_not receive(:check_assignment_remind)
      end
    end

    context "when check has assigned user today" do
      let(:check_assignments_repository) do
        create_check_assignments_repository(check_assignment)
      end

      before do
        allow(check_assignment).to receive(:created_at) { Time.current }
      end

      it "doesn't send any reminder" do
        expect(UserReminderMailer).to_not receive(:check_assignment_remind)
      end
    end

    context "when check has assigned user 15 days ago" do
      let(:check_assignments_repository) do
        create_check_assignments_repository(check_assignment)
      end

      before do
        allow(check_assignment).to receive(:created_at) { 15.days.ago }
        allow(UserReminderMailer)
          .to receive_message_chain(:check_assignment_remind, :deliver_now)
      end

      it "sends reminder" do
        expect(UserReminderMailer).to receive(:check_assignment_remind)
      end
    end

    context "when check has completion_date" do
      let(:check_assignments_repository) do
        create_check_assignments_repository(check_assignment)
      end

      before do
        allow(check_assignment).to receive(:created_at) { 15.days.ago }
        allow(check_assignment).to receive(:completion_date) { Time.current }

        allow(UserReminderMailer)
          .to receive_message_chain(:check_assignment_remind, :deliver)
      end

      it "doesn't send any reminder" do
        expect(UserReminderMailer).to_not receive(:check_assignment_remind)
      end
    end
  end
end
