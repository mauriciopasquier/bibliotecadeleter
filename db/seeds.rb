# encoding: utf-8

# Carga los datos pregrabados de +db/semillas+
# Se pueden cargar de otro directorio llamando así:
#
#   dir=directorio rake db:seed
unless ENV['dir'].present?
  ENV['dir'] = 'semillas'
end

# yaml_db
Rake::Task['db:data:load_dir'].invoke

# pg_search
Rake::Task['extension:unaccent'].invoke

%w{Diseno Mazo Lista Version Expansion Artista Torneo}.each do |modelo|
  Rake::Task['pg_search:multisearch:rebuild'].invoke(modelo)
end
