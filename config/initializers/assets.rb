Rails.application.configure do
  # Asset pipeline
  config.assets.enabled = true

  # Traduzco el path
  config.assets.prefix = '/recursos'

  # Para precompilación local de assets
  # http://guides.rubyonrails.org/asset_pipeline.html#local-precompilation
  config.assets.initialize_on_precompile = false

  # Los pdfs van en documents
  config.assets.paths << Rails.root.join('app', 'assets', 'documents')
  config.assets.paths << Rails.root.join('app', 'assets', 'sounds')

  # Version of your assets, change this if you want to expire all your assets
  config.assets.version = '1.8'

  # Precompile additional assets.
  # application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
  # Rails.application.config.assets.precompile += %w( search.js )
end
