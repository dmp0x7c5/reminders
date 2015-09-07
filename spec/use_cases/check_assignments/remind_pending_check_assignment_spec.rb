require "rails_helper"

describe CheckAssignments::RemindPendingCheckAssignment do
  include RepositoriesHelpers

  let(:service) { described_class.new(project_check) }
  let(:user) { double(:user, id: 1, email: "john@doe.pl") }
  let(:check_assignment) do
    double(:check_assignment,
           id: 1, user_id: 1, project_check_id: 1, completion_date: nil,
           created_at: nil
          )
  end
  let(:users_repository) { create_repository(user) }

  let(:project_check) do
    double(:project_check, id: 1, created_at: Time.current, reminder_id: 1)
  end

  let(:reminders_repository) { create_repository(reminder) }

  describe "#perform" do
    before do
      check_assignments_repository.stub(:latest_assignment) do
        check_assignments_repository.all.last
      end
      service.check_assignments_repository = check_assignments_repository
      service.users_repository = users_repository
    end

    after do
      service.call
    end

    context "when check has no one assigned" do
      let(:check_assignments_repository) { create_repository }

      it "doesn't send any reminder" do
        expect(UserReminderMailer).to_not receive(:check_assignment_remind)
      end
    end

    context "when check has assigned user today" do
      let(:check_assignments_repository) { create_repository(check_assignment) }

      before do
        check_assignment.stub(:created_at) { Time.current }
      end

      it "doesn't send any reminder" do
        expect(UserReminderMailer).to_not receive(:check_assignment_remind)
      end
    end

    context "when check has assigned user 15 days ago" do
      let(:check_assignments_repository) { create_repository(check_assignment) }

      before do
        check_assignment.stub(:created_at) { 15.days.ago }
        UserReminderMailer.stub_chain(:check_assignment_remind, :deliver)
      end

      it "sends reminder" do
        expect(UserReminderMailer).to receive(:check_assignment_remind)
      end
    end

    context "when check has completion_date" do
      let(:check_assignments_repository) { create_repository(check_assignment) }

      before do
        check_assignment.stub(:created_at) { 15.days.ago }
        check_assignment.stub(:completion_date) { Time.current }

        UserReminderMailer.stub_chain(:check_assignment_remind, :deliver)
      end

      it "doesn't send any reminder" do
        expect(UserReminderMailer).to_not receive(:check_assignment_remind)
      end
    end
  end
end
