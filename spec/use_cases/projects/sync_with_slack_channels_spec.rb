require "spec_helper"

describe Projects::SyncWithSlackChannels do
  let(:project) do
    double(:project, id: 1, name: "baz", channel_name: "project-baz")
  end
  let(:project_channels) do
    [double(name: "project-foo"), double(name: "project-bar")]
  end
  let(:channels_repository) do
    double(:slack_channels_repository, all_project_channels: project_channels)
  end
  let(:projects_repository) do
    class ProjectsRepository < InMemoryRepository
      def find_by_name(name)
        all.find { |r| r.name == name }
      end
    end
    repo = ProjectsRepository.new
    repo.all = [project]
    repo
  end
  let(:service) do
    described_class.new projects_repository, channels_repository
  end

  describe "#call" do
    it "creates new projects based on project channels" do
      expect { service.call }.to change { projects_repository.all.count }.by(2)
    end

    it "creates new projects with name corresponding to the channel name" do
      service.call
      expect(projects_repository.all.map(&:name))
        .to include("foo", "bar", "baz")
    end

    it "creates new projects and saves channel name" do
      service.call
      expect(projects_repository.all.map(&:channel_name))
        .to include("project-foo", "project-bar", "project-baz")
    end
  end
end
