server 'bibliotecadeleter.com.ar', :app, :web, :db, primary: true
set :stage_name, 'production'
set :user, 'mpj'
set :deploy_to, '/srv/http/bibliotecadeleter.com.ar'
set :branch, 'master'
