# encoding: utf-8
# Recetas de Capistrano para configurar la aplicación
namespace :configs do
  # Debería ser linkeada después de +deploy:setup+
  desc "Crea el directorio para los archivos de configuración"
  task :directorios, roles: :app do
    run "mkdir -p #{shared_path}/cartas"
    run "mkdir -p #{shared_path}/config"
    run "mkdir -p #{shared_path}/backups-yml"
  end

  # Debería ser linkeada después de +deploy:setup+
  desc "Copia los archivos de configuración iniciales"
  task :archivos, roles: :app do
    upload "#{config_path}/$CAPISTRANO:HOST$/devise.rb",
              "#{shared_path}/config/", via: :scp
    upload "#{config_path}/$CAPISTRANO:HOST$/secret_token.rb",
              "#{shared_path}/config/", via: :scp
    upload "#{config_path}/$CAPISTRANO:HOST$/database.yml",
              "#{shared_path}/config/", via: :scp
    upload "#{config_path}/$CAPISTRANO:HOST$/production.rb",
              "#{shared_path}/config/", via: :scp
  end

  desc "Crea los links simbólicos de los archivos de configuración"
  task :links, roles: :app do
    run "rm #{release_path}/config/initializers/devise.dist.rb; ln -s #{shared_path}/config/devise.rb #{release_path}/config/initializers/devise.rb"
    run "rm #{release_path}/config/initializers/secret_token.dist.rb; ln -s #{shared_path}/config/secret_token.rb #{release_path}/config/initializers/secret_token.rb"
    run "rm #{release_path}/config/database.dist.yml; ln -s #{shared_path}/config/database.yml #{release_path}/config/database.yml"
    run "rm #{release_path}/config/environments/production.dist.rb; ln -s #{shared_path}/config/production.rb #{release_path}/config/environments/production.rb"

    # Crea el link simbólico para las imágenes de las cartas
    run "ln -s #{shared_path}/cartas #{release_path}/public/cartas"

    run "mkdir -p #{release_path}/tmp"
    run "ln -s #{shared_path}/sockets #{release_path}/tmp/"
  end

  desc 'Actualiza las imágenes de las cartas'
  task :imagenes do
    find_servers_for_task(current_task).each do |server|
      puts run_locally "rsync -av public/cartas/ #{user}@#{server.host}:#{shared_path}/cartas"
    end
  end
end
