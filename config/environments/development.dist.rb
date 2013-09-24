# Para ver los mails sin enviarlos en http://localhost:3000/mail
require 'mail_preview'
BibliotecaDelEter::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Log error messages when you accidentally call methods on nil.
  config.whiny_nils = true

  # Show full error reports and disable caching
  config.consider_all_requests_local       = true
  #config.action_controller.perform_caching = false

  # Habilito el cache para pruebas
  config.action_controller.perform_caching = true
  config.cache_store = :libmemcached_store

  # Para cachear los fragmentos de cache_digests en desarrollo y sin embargo
  # recomputarlos en cada request (si no, hay que reiniciar la aplicación
  # después de cada cambio)
  CacheDigests::TemplateDigestor.cache = ActiveSupport::Cache::NullStore.new

  # Don't care if the mailer can't send
  config.action_mailer.raise_delivery_errors = false
  # Devise necesita esto
  config.action_mailer.default_url_options = { :host => 'localhost:3000' }

  # Ejemplo de mailer con riseup
  ActionMailer::Base.smtp_settings = {
    address: 'mail.riseup.net',

    # usar TLS
    enable_starttls_auto: true,

    # puerto para TLS
    port:                 587,

    # dominio desde el que enviamos
    domain:               'un-dominio-que-apunte-aca.com.ar',

    user_name:            'usuario',
    password:             'password',

    # envía en texto plano pero envuelto en TLS
    authentication:       :plain
  }

  # Print deprecation notices to the Rails logger
  config.active_support.deprecation = :log

  # Only use best-standards-support built into browsers
  config.action_dispatch.best_standards_support = :builtin

  # Log the query plan for queries taking more than this (works
  # with SQLite, MySQL, and PostgreSQL)
  config.active_record.auto_explain_threshold_in_seconds = 0.5

  # Do not compress assets
  config.assets.compress = false

  # Expands the lines which load the assets
  config.assets.debug = true
end
