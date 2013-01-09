source 'https://rubygems.org'

gem 'rails', '3.2.9'

# Database
gem 'pg'

# Model
gem 'attribute_normalizer'
gem 'inflections', require: false # Se carga después que las custom y las borra
gem 'paperclip'

# View
gem 'dynamic_form'
gem 'haml-rails'
gem 'draper'
gem 'kaminari'
gem 'friendly_id'

# Controller
gem 'responders'
gem 'has_scope'

# Server
gem 'thin'

# Autenticación/autorización
gem 'devise'
gem 'cancan'

# I18n
gem 'rails-i18n'
gem 'devise-i18n'
gem 'i18n_country_select'

group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'jquery-rails'
  gem 'bootstrap-sass-rails'
  gem 'therubyracer', '= 0.10.1' # la 0.11 no me compila
  gem 'uglifier', '>= 1.0.3'
end

group :test, :development do
  gem 'minitest-rails'
  gem 'pry-rails'
  gem 'hirb'
end

group :development do
  gem 'bullet'
end

group :test do
  gem 'factory_girl_rails'
  gem 'minitest-rails-capybara'
end
