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

%w{Mazo Lista Version Expansion Artista Torneo}.each do |modelo|
  Rake::Task['pg_search:multisearch:rebuild'].invoke(modelo)
end

# Agregar bibliotecarios al grupo de forem
bs = Forem::Group.find_by(name: 'Bibliotecarios')
BIBLIOTECARIO.usuarios.each do |b|
  bs.members << b unless bs.members.include? b
  b.update(forem_admin: true, forem_state: 'approved')
end
