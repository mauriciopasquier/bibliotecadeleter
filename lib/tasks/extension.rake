namespace :extension do
  def conexion
    spec = ActiveRecord::Base.connection_config

    spec[:username] = ENV['usuario'] || 'postgres'
    spec[:password] = ENV['password'] || nil

    ActiveRecord::Base.establish_connection(spec).connection
  end

  desc "Instala la extensión unaccent con permiso de superusuario"
  task :unaccent => :environment do
    conexion.execute 'create extension if not exists unaccent'
  end

  namespace :unaccent do
    desc "Desinstala la extension unaccent"
    task :desinstalar => :environment do
      conexion.execute 'drop extension if exists hstore'
    end
  end
end
