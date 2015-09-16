require "rails_helper"

feature "pausing users" do
  let(:user) do
    create(:user,
           uid: "12331", provider: "google_oauth2",
           email: "john@doe.pl", admin: true, paused: false)
  end
  let(:second_user) do
    create(:user,
           name: "John Smith",
           email: "john@smith@foo.pl",
           paused: true)
  end
  let(:users_page) { Users::UsersPage.new }

  before do
    log_in(user)
    second_user.touch
  end

  pending "toggling state of paused in '/users' page" do
    users_page.load
    expect(users_page.user_rows.first.paused?).to be_falsy
    expect(users_page.user_rows.second.paused?).to be_truthy
    users_page.user_rows.first.pause!
    expect(users_page.user_rows.first.paused?).to be_truthy
    expect(user.reload.paused).to be_truthy
    users_page.user_rows.first.unpause!
    expect(users_page.user_rows.first.paused?).to be_falsy
  end
end
