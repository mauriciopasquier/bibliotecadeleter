require "bundler/capistrano"

set :application, "Biblioteca del Éter"

server            "hackcoop.com.ar", :app, :web, :db, primary: true
set :user,        "eter"

set :scm,         :git
set :repository,  "git@hackcoop.com.ar:eter.git"

# if you want to clean up old releases on each deploy uncomment this:
set :keep_releases, 5
after "deploy:restart", "deploy:cleanup"

# Evita que capistrano haga un clone completo del repositorio cada deploy
set :deploy_via, :remote_cache

# Crea el link simbólico para las imágenes de las cartas
namespace :deploy do
  namespace :assets do
    task :linkear_estaticos do
      run "ln -s #{shared_path}/cartas #{release_path}/public/cartas"
    end
  end
end

after "deploy:update_code", "deploy:assets:linkear_estaticos"

# If you are using Passenger mod_rails uncomment this:
# namespace :deploy do
#   task :start do ; end
#   task :stop do ; end
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#   end
# end
