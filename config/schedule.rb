# Learn more: http://github.com/javan/whenever

every 1.day, at: "09:30 am" do
  rake "reminders:check_all"
end

every 1.day, at "11:55 pm" do
  rake "project:sync_missing"
end
