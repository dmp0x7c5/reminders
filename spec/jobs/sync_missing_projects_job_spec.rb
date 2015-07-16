require "spec_helper"

describe SyncMissingProjectsJob do
  let(:job) do
    described_class.new(
      projects_repo: projects_repository,
      slack_repo: slack_repository,
      reminders_repo: reminders_repository,
      checks_repo: checks_repository,
    )
  end

  let(:reminder1) do
    double(:reminder, id: 1, projects: [],
                      project_checks: [])
  end

  let(:reminder2) do
    double(:reminder, id: 2, projects: [],
                      project_checks: [])
  end

  let(:project_channels) do
    [double(name: "project-one"), double(name: "project-two")]
  end

  let(:reminders_repository) do
    repo = InMemoryRepository.new
    repo.all = [reminder1, reminder2]
    repo
  end

  let(:slack_repository) do
    double(:slack_channels_repository, all_project_channels: project_channels)
  end

  let(:projects_repository) do
    class InMemoryProjectsRepository < InMemoryRepository
      def find_by_name(name)
        all.find { |r| r.name == name }
      end

      def for_reminder(_reminder)
        []
      end
    end
    InMemoryProjectsRepository.new
  end

  let(:checks_repository) do
    class InMemoryChecksRepository < InMemoryRepository
      def for_reminder(reminder)
        records.values.select { |r| r.reminder_id == reminder.id }
      end
    end
    InMemoryChecksRepository.new
  end

  describe "#perform" do
    context "with Slack disabled" do
      before do
        allow(AppConfig).to receive(:slack_enabled)
          .and_return(false)
      end

      it "does nothing" do
        expect { job.perform }.not_to change { projects_repository.all.count }
        expect { job.perform }
          .not_to change { checks_repository.for_reminder(reminder1).count }
        expect { job.perform }
          .not_to change { checks_repository.for_reminder(reminder2).count }
      end
    end

    context "with Slack enabled" do
      before do
        allow(AppConfig).to receive(:slack_enabled)
          .and_return(true)
      end

      it "creates project" do
        expect { job.perform }.to change { projects_repository.all.count }.by(2)
      end

      it "synchronises new projects with existing reminders" do
        expect { job.perform }
          .to change { checks_repository.for_reminder(reminder1).count }.by(2)
        expect { job.perform }
          .to change { checks_repository.for_reminder(reminder2).count }.by(2)
      end
    end
  end
end
