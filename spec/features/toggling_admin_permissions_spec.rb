require "rails_helper"

feature "toggling admin permissions and archivisation" do
  let(:user) { create(:admin) }
  let(:second_user) { create(:user) }
  let(:page) { Users::UsersPage.new }

  before do
    log_in(user)
    second_user.touch
  end

  scenario "toggling admin permissions", focus: true do
    page.load

    expect(page.user_rows.first).to have_admin_label
    expect(page.user_rows.second).to_not have_admin_label

    page.user_rows.second.toggle_admin_permissions!

    expect(page).to have_flash_notice
    expect(page.flash_notice.text)
      .to include("User's permissions has been changed.")
    expect(page.user_rows.second).to have_admin_label

    page.user_rows.second.toggle_admin_permissions!

    expect(page.user_rows.second).to_not have_admin_label
  end

  scenario "archiving user" do
    page.load

    expect(page.user_rows.first).to have_text(user.name)
    expect(page.user_rows.second).to have_text(second_user.name)

    expect(page.user_rows.count).to eq 2

    page.user_rows.second.archive_user!
    expect(page.flash_notice.text).to include("User has been archived.")

    expect(page.user_rows.count).to eq 1
  end
end
