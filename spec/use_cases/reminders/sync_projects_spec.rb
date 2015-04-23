require "spec_helper"

describe Reminders::SyncProjects do
  let(:reminder) { double(:reminder, id: 1) }
  let(:projects_repo) { double(:projects_repository) }
  let(:project_checks_repo) { double(:project_checks_repository) }
  let(:project1) { double(:project, id: 1) }
  let(:project2) { double(:project, id: 2) }
  let(:project3) { double(:project, id: 3) }
  let(:all_projects) { [project1, project2, project3] }
  let(:reminder_projects) { [project1] }
  subject { described_class.new(reminder, projects_repo, project_checks_repo) }

  describe "call" do
    before do
      expect(projects_repo).to receive(:all) { all_projects }
      expect(projects_repo).to receive(:for_reminder)
        .with(reminder) { reminder_projects }
    end

    context "where there is no new projects" do
      let(:all_projects) { [] }

      it "doesn't create any check" do
        expect(project_checks_repo).to_not receive(:create)
        subject.call
      end
    end

    it "creates new project checks for each new project" do
      expect(project_checks_repo).to receive(:create)
        .with(project_id: 2, reminder_id: reminder.id)
      expect(project_checks_repo).to receive(:create)
        .with(project_id: 3, reminder_id: reminder.id)
      subject.call
    end
  end
end
