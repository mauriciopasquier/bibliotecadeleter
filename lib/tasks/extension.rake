namespace :extension do
  def conexion
    require 'io/console'

    spec = ActiveRecord::Base.connection_config

    spec[:username] = if ENV['usuario'].present?
      ENV['usuario']
    else
      puts "Superusuario de la base de datos:"
      STDIN.noecho(&:gets).chomp
    end

    spec[:password] = if ENV['password'].present?
      ENV['password']
    else
      puts "Password del superusuario:"
      STDIN.noecho(&:gets).chomp
    end

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
