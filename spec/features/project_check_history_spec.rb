require "rails_helper"

feature "project checks history" do
  let(:project) { create(:project) }
  let(:reminder) { create(:reminder) }
  let!(:project_check) do
    create(:project_check,
           project: project,
           reminder: reminder,
          )
  end

  let(:user) { create(:user, uid: "213312", provider: "google_oauth2") }
  let(:page) { Reminders::ReminderPage.new }
  let(:second_user) { create(:user, name: "Sam Smith") }

  before do
    log_in(user)
  end

  scenario "history shows only done project checks" do
    page.load reminder_id: reminder.id

    expect(page.first_project)
      .not_to have_text user.name

    page.first_project.check_button.click

    expect(page.first_project.last_checker)
      .to have_text user.name
    expect(page.first_project.assigned_reviewer)
      .not_to have_text second_user.name

    page.first_project.history_button.click

    expect(page.first_project.checks_history)
      .to have_text user.name

    page.first_project.pick_random_button.click

    expect(page.first_project.assigned_reviewer)
      .to have_text second_user.name
    expect(page.first_project.checks_history)
      .to have_text user.name
    expect(page.first_project.checks_history)
      .not_to have_text second_user.name

    page.first_project.check_button.click
    page.first_project.history_button.click

    expect(page.first_project.checks_history)
      .not_to have_text second_user.name
  end
end
