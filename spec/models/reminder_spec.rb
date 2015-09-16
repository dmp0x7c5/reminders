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

    it "deletes reminder" do
      expect { reminder.destroy }.to change { Reminder.count }.by(-1)
    end

    it "deletes dependent project_checks" do
      expect { reminder.destroy }.to change { ProjectCheck.count }.by(-1)
    end

    it "deletes dependent check_assignments" do
      expect { reminder.destroy }.to change { CheckAssignment.count }.by(-1)
    end

    it "deletes dependent skills" do
      expect { reminder.destroy }.to change { Skill.count }.by(-1)
    end
  end
end
