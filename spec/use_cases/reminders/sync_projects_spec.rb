require "spec_helper"

describe Reminders::SyncProjects do
  let(:reminder) { double(:reminder, id: 1) }
  let(:projects_repo) { double(:projects_repository) }
  let(:project_checks_repo) { InMemoryRepository.new }
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
      all_projects.each do |project|
        allow(project).to receive(:enabled)
      end
    end

    context "where there is no new projects" do
      let(:all_projects) { [] }

      it "doesn't create any check" do
        expect { subject.call }.to_not change { project_checks_repo.all.count }
      end
    end

    it "creates new project checks for each new project" do
      expect { subject.call }.to change { project_checks_repo.all.count }.by(2)
    end

    context "when one of projects is disabled" do
      let(:project1_checks) do
        project_checks_repo.all.select { |pc| pc.project_id == project2.id }
      end
      let(:project2_checks) do
        project_checks_repo.all.select { |pc| pc.project_id == project3.id }
      end

      before do
        allow(project2).to receive(:enabled)
          .and_return(false)
        allow(project3).to receive(:enabled)
          .and_return(true)
        allow(project1).to receive(:project_checks)
          .and_return(:project1_checks)
        allow(project2).to receive(:project_checks)
          .and_return(:project2_checks)
      end

      it "creates project check with the same state as project" do
        subject.call

        expect(project1_checks.first.enabled).to be false
        expect(project2_checks.first.enabled).to be true
      end
    end
  end
end
