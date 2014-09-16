# Use this hook to configure merit parameters
Merit.setup do |config|
  # Check rules on each request or in background
  # config.checks_on_each_request = true

  # Define ORM. Could be :active_record (default) and :mongo_mapper and
  # :mongoid
  # config.orm = :active_record

  # Define :user_model_name. This model will be used to grand badge if no :to
  # option is given. Default is "User".
  config.user_model_name = "Usuario"

  # Define :current_user_method. Similar to previous option. It will be used to
  # retrieve :user_model_name object if no :to option is given. Default is
  # "current_#{user_model_name.downcase}".
  config.current_user_method = "current_usuario"
end

# Create application badges (uses https://github.com/norman/ambry)

# Guardar cada medalla en una constante, útil para agregar medallas con
# `@usuario.add_badge(CONSTANTE.id)`
# Prioridad es para ordenar las reglas de CanCan
BIBLIOTECARIO = Merit::Badge.create! id: 1, name: 'bibliotecario',
  description: 'Los Bibliotecarios del Éter se encargan de que cada tomo tenga su lugar y cada socio su merecido',
  custom_fields: { prioridad: 1 }

SOCIO = Merit::Badge.create! id: 2, name: 'socio',
  description: 'Los Socios de la Biblioteca sólo han dado su primer paso hacia el poder y conocimiento que esta ofrece',
  custom_fields: { prioridad: 90 }

TRATANTE = Merit::Badge.create! id: 3, name: 'tratante',
  description: 'Los tratantes ofrecen conocimiento a cambio de riqueza y poder',
  custom_fields: { prioridad: 45 }
