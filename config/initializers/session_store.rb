# Be sure to restart your server when you modify this file.
require 'action_dispatch/session/libmemcached_store'

Rails.application.configure do

  # Guardar la sesión en memcached
  config.session_store :libmemcached_store, namespace: '_session', expire_after: 7200

  # Rack::Protection dice que hay que cargar estos después de la sesión
  config.middleware.use Rack::Protection::SessionHijacking
  config.middleware.use Rack::Protection::RemoteToken
end
