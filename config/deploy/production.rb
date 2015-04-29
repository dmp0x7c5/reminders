require "net/ssh/proxy/command"
server ENV["REMINDERS_SERVER_HOST"], user: ENV["REMINDERS_SERVER_USER"], roles: %w(web app db)
server ENV["REMINDERS_SERVER_HOST_2"], user: ENV["REMINDERS_SERVER_USER"], roles: %w(web app)
set :ssh_options, proxy: Net::SSH::Proxy::Command.new("ssh #{ENV['REMINDERS_GATEWAY']} -W %h:%p")
set :branch, "production"
