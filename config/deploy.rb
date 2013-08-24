require 'bundler/capistrano'

set :application, 'BibliotecaDelEter'

server            'hackcoop.com.ar', :app, :web, :db, primary: true
set :user,        'eter'
set :deploy_to,   '/opt/eter/app'

set :use_sudo,    false
set :ssh_options, { forward_agent: true}

set :scm,         :git
set :repository,  'git@hackcoop.com.ar:eter.git'

# if you want to clean up old releases on each deploy uncomment this:
set :keep_releases, 5

# Evita que capistrano haga un clone completo del repositorio cada deploy
set :deploy_via, :remote_cache

set :assets_prefix, 'recursos'
set :imagenes_seed, 'semillas'
set :rake, 'RAILS_ENV=production bundle exec rake'

namespace :deploy do
  namespace :assets do
    desc 'Construye los estilos nuevos de paperclip'
    task :refresh_styles, roles: :app do
      run "cd #{release_path}; #{rake} paperclip:refresh:missing_styles"
    end

    desc 'Crea el link simbólico para las imágenes de las cartas'
    task :linkear_estaticos do
      run "ln -s #{shared_path}/cartas #{release_path}/public/cartas"
    end
  end
end

namespace :configurar do
  desc 'Crea los directorios necesarios'
  task :directorios do
    # Para mantenerlas fuera del control de assets de capistrano, que puede
    # borrar los viejos, y fuera de public en el repositorio
    run "mkdir -p #{shared_path}/cartas"
  end

  desc 'Crea los links simbólicos de los archivos de configuración'
  task :archivos do
    run "ln -s #{shared_path}/config/devise.rb #{release_path}/config/initializers/devise.rb"
    run "ln -s #{shared_path}/config/secret_token.rb #{release_path}/config/initializers/secret_token.rb"
    run "ln -s #{shared_path}/config/database.yml #{release_path}/config/database.yml"
    run "ln -s #{shared_path}/config/production.rb #{release_path}/config/environments/production.rb"
  end
end

namespace :utils do
  desc 'Uploads a directory. Use from=local_dir to=remote_dir.'
  task :upload_dir do
    local = ENV['from']
    remote = ENV['to']
    upload("#{local}", "#{remote}")
  end
end

# Adaptadas de https://gist.github.com/157958
namespace :db do
  desc 'Actualiza las imágenes de las cartas'
  task :imagenes do
    # FIXME No hardcodear el server
    puts run_locally "rsync -av public/cartas/ #{user}@hackcoop.com.ar:#{shared_path}/cartas"
  end
  desc 'Create production database'
  task :create do
    run "cd #{current_path}; #{rake} db:create"
  end

  desc 'Populates the production database'
  task :seed do
    run "cd #{current_path}; #{rake} db:seed"
  end

  desc 'Sets up the production database'
  task :setup do
    run "cd #{current_path}; #{rake} db:setup"
  end

  desc 'Resets the production database'
  task :reset do
    run "cd #{current_path}; #{rake} db:reset"
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

after   'deploy:setup',             'configurar:directorios'
after   'deploy:assets:precompile', 'deploy:assets:linkear_estaticos'
before  'deploy:finalize_update',   'configurar:archivos'
after   'deploy:restart',           'deploy:cleanup'
