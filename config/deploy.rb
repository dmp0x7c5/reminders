lock "3.4.0"

set :application, "reminders"
set :repo_url,  "git://github.com/netguru/reminders.git"
set :deploy_to, ENV["REMINDERS_DEPLOY_PATH"]

set :linked_files, %w(config/database.yml config/secrets.yml)

set :linked_dirs, %w(bin log tmp vendor/bundle public/uploads)
