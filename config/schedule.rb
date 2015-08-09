# Learn more: http://github.com/javan/whenever

# Monday-Friday at 9:30AM
every "30 9 * * 1-5" do
  rake "reminders:check_all"
end

every 1.day, at: "11:55 pm" do
  rake "projects:sync_missing"
end
