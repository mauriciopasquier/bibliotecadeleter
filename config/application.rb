# encoding: utf-8
require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env)

module BibliotecaDelEter
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Custom directories with classes and modules you want to be autoloadable.
    config.autoload_paths += %W(#{config.root}/lib/extensiones/)
    config.autoload_paths += %W(#{config.root}/lib/responders/)

    # Sólo incluyo el helper del controlador
    config.action_controller.include_all_helpers = false

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    config.i18n.default_locale = :es

    # Configure the default encoding used in templates for Ruby 1.9.
    config.encoding = "utf-8"

    # Enable escaping HTML in JSON.
    config.active_support.escape_html_entities_in_json = true

    # Use SQL instead of Active Record's schema dumper when creating the database.
    # This is necessary if your schema can't be completely dumped by the schema dumper,
    # like if you have constraints or database-specific column types
    # config.active_record.schema_format = :sql

    config.generators do |g|
      g.test_framework :mini_test, spec: true, fixture: false
      g.stylesheets false
      g.javascripts false
      g.helper false
    end

    # Asset pipeline
    config.assets.enabled = true

    # Traduzco el path
    config.assets.prefix = "/recursos"

    # Para precompilación local de assets
    # http://guides.rubyonrails.org/asset_pipeline.html#local-precompilation
    config.assets.initialize_on_precompile = false

    # Los pdfs van en documents
    config.assets.paths << Rails.root.join('app', 'assets', 'documents')
    config.assets.paths << Rails.root.join('app', 'assets', 'sounds')

    # Version of your assets, change this if you want to expire all your assets
    config.assets.version = '1.6.7'
  end
end
