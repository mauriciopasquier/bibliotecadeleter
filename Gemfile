source 'https://rubygems.org'

gem 'rails', '3.2.14'

# Database
gem 'pg'
# Rama con un parche para que las join tables salgan ordenadas
gem 'yaml_db', github: 'mauriciopasquier/yaml_db', branch: 'order-join-tables'

# Model
gem 'attribute_normalizer'
gem 'inflections', require: false
gem 'paperclip'
gem 'squeel'
gem 'amoeba'

# View
gem 'dynamic_form'
gem 'haml-rails'
gem 'draper'
gem 'kaminari'
gem 'friendly_id'
gem 'ransack'
gem 'sitemap'
gem 'rails3-jquery-autocomplete',
  github: 'mauriciopasquier/rails3-jquery-autocomplete',
  branch: 'scopes-with-parameters'

# Controller
gem 'responders'
gem 'has_scope'

# Server
gem 'thin'
gem 'cache_digests'
gem 'rails3_libmemcached_store'

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
  gem 'therubyracer'
  gem 'uglifier', '>= 1.0.3'
  gem 'uri-js-rails'
  gem 'turbolinks'
  gem 'jquery-ui-rails'
end

group :test, :development do
  gem 'minitest-rails'
  gem 'pry-rails'
  gem 'hirb'
end

group :development do
  gem 'bullet'
  gem 'capistrano'
end

group :test do
  gem 'factory_girl_rails'
  gem 'minitest-rails-capybara'
  gem 'turn'
end
