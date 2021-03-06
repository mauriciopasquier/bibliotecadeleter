# Recetas para Capistrano relacionadas con los backups
# Opciones que hay que definir en la configuración:
#   backup_remoto: directorio donde se guardan los backups en el server
#   backup_local:  directorio donde se guardan los backups en la máquina local

namespace :eter do
  # Depende de +yaml_db+
  desc "Genera un backup en .yml"
  task :backup do
    on roles(:app) do
      within current_path do
        with rails_env: fetch(:rails_env) do
          info 'Generando db/data.yml'
          execute :rake, 'db:data:dump'

          info 'Moviendo db/data.yml al repositorio'
          execute :mv, 'db/data.yml', 'db/backup'

          within 'db/backup' do
            info 'Commiteando. Si falla, es que no había cambios'
            execute :git, "commit -qam '#{Time.now}'", raise_on_non_zero_exit: false
          end
        end
      end
    end
  end
end
