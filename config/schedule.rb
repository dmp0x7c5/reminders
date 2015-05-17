# Learn more: http://github.com/javan/whenever

every 1.day, at: "09:30 am" do
  rake "reminders:check_all"
end
