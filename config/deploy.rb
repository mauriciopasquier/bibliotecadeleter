# config valid only for current version of Capistrano
lock '3.4.0'

set :application, 'BibliotecaDelEter'
set :repo_url, 'git@github.com:mauriciopasquier/bibliotecadeleter.git'

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
# set :deploy_to, '/var/www/my_app_name'

set :linked_files, fetch(:linked_files, []).push(
  'config/database.yml',
  'config/environments/production.rb',
  'config/initializers/secret_token.rb',
  'config/initializers/devise.rb'
)
set :linked_dirs, fetch(:linked_dirs, []).push(
  'log',
  'tmp/pids',
  'tmp/cache',
  'tmp/sockets',
  'vendor/bundle',
  'public/system',
  'public/recursos',
  'db/backup'
)

set :assets_prefix, 'recursos'

#after 'deploy:started', 'eter:backup'
