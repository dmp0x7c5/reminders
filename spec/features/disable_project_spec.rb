require "rails_helper"

feature "toggling project state" do
  let(:user) { create(:user, uid: "1234", provider: "google_oauth2") }
  let(:projects_page) { Projects::ProjectsPage.new }
  let(:reminder_page) { Reminders::ReminderPage.new }
  let!(:project) { create(:project) }
  let(:reminder_1) { create(:reminder) }
  let(:reminder_2) { create(:reminder) }

  before do
    log_in(user)
    [reminder_1, reminder_2].each do |reminder|
      create(:project_check,
             project_id: project.id,
             reminder_id: reminder.id,
            )
    end
  end

  scenario "user disables project" do
    projects_page.load
    expect(projects_page.first_project.disabled?).to be false
    projects_page.first_project.disable
    expect(projects_page.first_project.disabled?).to be true

    reminder_page.load reminder_id: reminder_1.id
    expect(reminder_page.first_project.disabled?).to be true
    expect(reminder_page.first_project).not_to have_button("Check")

    reminder_page.load reminder_id: reminder_2.id
    expect(reminder_page.first_project.disabled?).to be true
    expect(reminder_page.first_project).not_to have_button("Check")
  end
end
