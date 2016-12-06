`ssh-add` # 注意這是鍵盤左上角的「 `」不是單引號「 '」
set :application, 'sports_link'

set :repo_url, 'git@github.com:jackal998/sports_link.git'
set :deploy_to, '/home/deploy/sports_link'
set :keep_releases, 5

append :linked_files, 'config/database.yml', 'config/secrets.yml', 'config/google.yml'
# 如果有 facebook.yml 或 email.yml 想要連結的話，也要加進來

append :linked_dirs, 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'public/system'

set :passenger_restart_with_touch, true