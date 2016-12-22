`ssh-add`
set :application, 'sports_link'

set :repo_url, 'git@github.com:jackal998/sports_link.git'
set :deploy_to, '/home/deploy/sports_link'
set :keep_releases, 5

append :linked_files, 'config/database.yml', 'config/secrets.yml', 'config/google.yml', 'config/facebook.yml'

append :linked_dirs, 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'public/system'

set :passenger_restart_with_touch, true