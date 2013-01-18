require "bundler/capistrano"

set :application, "BibliotecaDelEter"

server            "hackcoop.com.ar", :app, :web, :db, primary: true
set :user,        "eter"
set :deploy_to,   "~/app"
set :use_sudo,    false
set :ssh_options, { forward_agent: true}

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
    desc "Crea el link simbólico para las imágenes de las cartas"
    task :linkear_estaticos do
      run "ln -s #{shared_path}/cartas #{release_path}/public/cartas"
    end

    desc "Construye los estilos nuevos de paperclip"
    task :refresh_styles, roles: :app do
      run "cd #{release_path}; RAILS_ENV=production bundle exec rake paperclip:refresh:missing_styles"
    end
  end

  namespace :config do
    desc "Crea los links simbólicos de los archivos de configuración"
    task :linkear_config do
      run "ln -s #{shared_path}/config/devise.rb #{release_path}/config/initializers/devise.rb"
      run "ln -s #{shared_path}/config/secret_token.rb #{release_path}/config/initializers/secret_token.rb"
      run "ln -s #{shared_path}/config/database.yml #{release_path}/config/database.yml"
      run "ln -s #{shared_path}/config/production.rb #{release_path}/config/environments/production.rb"
    end
  end
end

after "deploy:create_symlink", "deploy:config:linkear_config"
after "deploy:create_symlink", "deploy:assets:linkear_estaticos"
after "deploy:update_code", "deploy:assets:refresh_styles"

# If you are using Passenger mod_rails uncomment this:
# namespace :deploy do
#   task :start do ; end
#   task :stop do ; end
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#   end
# end
