require "rails_helper"

describe Reminder do
  let!(:reminder) { create(:reminder) }

  context "Destroing" do
    let!(:project_check) { create(:project_check, reminder: reminder) }
    let(:user) { create(:user) }
    let!(:check_assignment) do
      create(:check_assignment, project_check: project_check, user: user)
    end
    let!(:skill) { create(:skill, user: user, reminder: reminder) }

    before { reminder.destroy }

    it "deletes reminder" do
      expect { reminder.reload }.to raise_error(ActiveRecord::RecordNotFound)
    end

    it "deletes dependent project_checks" do
      expect { project_check.reload }
        .to raise_error(ActiveRecord::RecordNotFound)
    end

    it "deletes dependent check_assignments" do
      expect { check_assignment.reload }
        .to raise_error(ActiveRecord::RecordNotFound)
    end

    it "deletes dependent skills" do
      expect { skill.reload }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
