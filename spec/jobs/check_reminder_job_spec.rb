require "spec_helper"

describe CheckReminderJob do
  let(:job) { described_class.new(reminder.id) }
  let(:reminder) do
    double(:reminder, id: 1, valid_for_n_days: days_valid,
                      remind_after_days: daily_reminders)
  end
  let(:daily_reminders) { [1, 2] }
  let(:days_valid) { 11 }
  let(:reminders_repository) do
    repo = InMemoryRepository.new
    repo.all = [reminder]
    repo
  end
  let(:check_1) { double(id: 21) }
  let(:check_2) { double(id: 12) }
  let(:project_checks_repository) do
    checks = [check_1, check_2]
    double(:project_checks_repository, for_reminder: checks)
  end

  describe "#perform" do
    before do
      job.reminders_repository = reminders_repository
      job.project_checks_repository = project_checks_repository
    end

    it "creates a job for each check belonging to the reminder" do
      expect(ProjectCheckedOnTimeJob).to receive(:perform_later)
        .with(check_1.id, days_valid, daily_reminders)
      expect(ProjectCheckedOnTimeJob).to receive(:perform_later)
        .with(check_2.id, days_valid, daily_reminders)

      job.perform reminder.id
    end
  end
end
