require "rails_helper"

feature "assign user to perform check" do
  let(:project) { create(:project) }
  let(:reminder) { create(:reminder) }
  let!(:project_check) do
    create(:project_check,
           project: project,
           reminder: reminder,
          )
  end
  let(:user) { User.first }

  before do
    log_in
  end

  scenario "there is no user assigned yet" do
    visit reminder_path(reminder)
    expect(page).not_to have_text user.name
    expect(page).to have_button("Pick random")

    click_button("Pick random")

    expect(page).to have_text user.name
    expect(page).not_to have_button("Pick random")
  end
end
