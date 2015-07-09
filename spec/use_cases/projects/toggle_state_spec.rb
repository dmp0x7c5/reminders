require "spec_helper"

describe Projects::ToggleState do
  let(:service) do
    described_class.new(project: project,
                        projects_repository: projects_repository,
                        checks_repository: project_checks_repository,
                       )
  end
  let(:project) do
    Project.new(enabled: nil,
                name: "some_name",
                project_checks: [check_1, check_2],
               )
  end

  let(:check_1) { ProjectCheck.new(enabled: true) }
  let(:check_2) { ProjectCheck.new(enabled: true) }

  class InMemoryRepositoryExtended < InMemoryRepository
    def update(object, attributes)
      record = find(object.id)
      attributes.each do |key, value|
        record[key] = value
      end
    end
  end

  let(:projects_repository) do
    repo = InMemoryRepositoryExtended.new
    repo.create(project)
    repo
  end

  let(:project_checks_repository) do
    repo = InMemoryRepositoryExtended.new
    repo.create(check_1)
    repo.create(check_2)
    repo
  end

  describe "#toggle" do
    context "with enabled project" do
      before do
        project.enabled = true
        project.project_checks = [check_1, check_2]
      end

      it "disables project" do
        expect(project.enabled).to be true
        service.toggle
        expect(project.enabled).to be false
      end

      it "disables all reminders for project" do
        expect(check_1.enabled).to be true
        expect(check_2.enabled).to be true
        service.toggle
        expect(check_1.enabled).to be false
        expect(check_2.enabled).to be false
      end
    end

    context "with disabled project" do
      before do
        project.enabled = false
        check_1.enabled = false
      end

      it "enables project" do
        expect(project.enabled).to be false
        service.toggle
        expect(project.enabled).to be true
      end

      it "enables all reminders for project" do
        expect(check_1.enabled).to be false
        expect(check_2.enabled).to be true
        service.toggle
        expect(check_1.enabled).to be true
        expect(check_2.enabled).to be true
      end
    end
  end
end
