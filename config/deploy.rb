require "bundler/capistrano"

set :application, "BibliotecaDelEter"

server            "hackcoop.com.ar", :app, :web, :db, primary: true
set :user,        "eter"
set :deploy_to,   "/opt/eter/app"

# Si no se la mandás con cap -S branch='rama' deploy, usa 'master'
set :branch, fetch(:branch, "master")

set :use_sudo,    false
set :ssh_options, { forward_agent: true}

set :scm,         :git
set :repository,  "git@hackcoop.com.ar:eter.git"

# if you want to clean up old releases on each deploy uncomment this:
set :keep_releases, 5
after "deploy:restart", "deploy:cleanup"

# Evita que capistrano haga un clone completo del repositorio cada deploy
set :deploy_via, :remote_cache

set :assets_prefix, "e"
set :imagenes_seed, "semillas"
set :rake, "RAILS_ENV=production bundle exec rake"

# Crea el link simbólico para las imágenes de las cartas
namespace :deploy do
  namespace :assets do
    desc "Construye los estilos nuevos de paperclip"
    task :refresh_styles, roles: :app do
      run "cd #{release_path}; #{rake} paperclip:refresh:missing_styles"
    end
  end
end

namespace :configurar do
  desc "Crea los links simbólicos de los archivos de configuración"
  task :archivos do
    run "ln -s #{shared_path}/config/devise.rb #{release_path}/config/initializers/devise.rb"
    run "ln -s #{shared_path}/config/secret_token.rb #{release_path}/config/initializers/secret_token.rb"
    run "ln -s #{shared_path}/config/database.yml #{release_path}/config/database.yml"
    run "ln -s #{shared_path}/config/production.rb #{release_path}/config/environments/production.rb"
  end
end

namespace :utils do
  desc "Uploads a directory. Use from=local_dir to=remote_dir."
  task :upload_dir do
    local = ENV['from']
    remote = ENV['to']
    upload("#{local}", "#{remote}")
  end
end

# Adaptadas de https://gist.github.com/157958
namespace :db do
  desc "Actualiza las imágenes de las cartas"
  task :imagenes do
    puts run_locally "rsync -av public/e/cartas #{user}@hackcoop.com.ar:#{shared_path}/assets"
  end
  desc "Create production database"
  task :create do
    run "cd #{current_path}; #{rake} db:create"
  end

  desc "Populates the production database"
  task :seed do
    expansiones = ENV['expansiones'].present? ? "expansiones=#{ENV['expansiones']}" : nil
    run "cd #{current_path}; #{rake} db:seed dir=#{shared_path}/#{imagenes_seed} #{expansiones}"
  end

  desc "Sets up the production database"
  task :setup do
    run "cd #{current_path}; #{rake} db:setup dir=#{shared_path}/#{imagenes_seed}"
  end

  desc "Resets the production database"
  task :reset do
    run "cd #{current_path}; #{rake} db:reset dir=#{shared_path}/#{imagenes_seed}"
  end
end

# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end

before "deploy:finalize_update", "configurar:archivos"
before "deploy:finalize_update", "configurar:directorios"
