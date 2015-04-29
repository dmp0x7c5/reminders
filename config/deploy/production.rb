server ENV["REMINDERS_SERVER_HOST"], user: ENV["REMINDERS_SERVER_USER"], roles: %w(web app db)
server ENV["REMINDERS_SERVER_HOST_2"], user: ENV["REMINDERS_SERVER_USER"], roles: %w(web app)
set :branch, "production"
