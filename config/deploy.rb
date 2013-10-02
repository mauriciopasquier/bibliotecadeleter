require 'bundler/capistrano'

load 'lib/recipes/configs'
load 'lib/recipes/utils'
load 'lib/recipes/db'
load 'lib/recipes/passenger'
load 'lib/recipes/precompilar_localmente'
load 'lib/recipes/backup'

# Multistage
set :stages, ['localhost', 'staging', 'production']
set :default_stage, 'localhost'
require 'capistrano/ext/multistage'

# Común para todos los stages
set :application, 'BibliotecaDelEter'

# Para que bash cargue .bashrc y los demás archivos como si se logueara alguien
set :default_shell, 'bash -l'
set :use_sudo,    false
set :ssh_options, { forward_agent: true}
set :scm,         :git
set :repository,  'git@repo.hackcoop.com.ar:mpj/eter.git'

# if you want to clean up old releases on each deploy uncomment this:
set :keep_releases, 5

# Evita que capistrano haga un clone completo del repositorio cada deploy
set :deploy_via, :remote_cache

# Para los stages?
set :rails_env, 'production'

# Variables de las librerías o configuraciones personales
set :assets_prefix, 'recursos'
set :backup_remoto, 'backups-yml'
set :imagenes_seed, 'semillas'
set :config_path, 'tmp/config'
set :rake, "RAILS_ENV=#{rails_env} bundle exec rake"
set :rsync, 'rsync -avzh --rsh=ssh'

after   'deploy:setup',             'configs:directorios'
after   'deploy:setup',             'configs:archivos'
after   'deploy:setup',             'configs:imagenes'
before  'deploy:finalize_update',   'configs:links'
before  'deploy:finalize_update',   'backup'
after   'deploy:update_code',       'deploy:assets:precompilar_localmente'
after   'deploy:restart',           'deploy:cleanup'
