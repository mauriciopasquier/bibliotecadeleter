server 'localhost', :app, :web, :db, primary: true
set :stage_name, 'localhost'
set :user, 'mauricio'
set :deploy_to, '/srv/http/nginx/eter.fibonacci.local'
