source 'https://rubygems.org'

gem 'rails', '3.2.15'

# Database
gem 'pg'
gem 'pg_search'
# Rama con un parche para que las join tables salgan ordenadas
gem 'yaml_db', github: 'mauriciopasquier/yaml_db', branch: 'order-join-tables'

# Model
gem 'attribute_normalizer'
gem 'inflections', require: false
gem 'paperclip'
gem 'squeel'
gem 'amoeba'
gem 'loofah'
gem 'state_machine'

# View
gem 'dynamic_form'
gem 'haml-rails'
gem 'draper'
gem 'kaminari'
gem 'friendly_id'
gem 'ransack'
gem 'sitemap'
gem 'rails3-jquery-autocomplete'
gem 'awesome_nested_fields'
gem 'kramdown'
gem 'lazyload-rails'
gem 'prawn'

# Controller
gem 'responders'
gem 'has_scope'
# TODO sacar con rails 4
gem 'strong_parameters', github: 'mauriciopasquier/strong_parameters', branch: 'permit-filters-array'

# Server
gem 'thin'
gem 'cache_digests'
gem 'rails3_libmemcached_store'
gem 'rack-protection'

# Autenticación/autorización
gem 'devise'
gem 'cancan'
gem 'merit'

# I18n
gem 'rails-i18n'
gem 'devise-i18n'
gem 'i18n_country_select'

# Development
gem 'minitest-rails'

group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'jquery-rails'
  gem 'bootstrap-sass-rails', '< 3.0.0'
  gem 'therubyracer'
  gem 'uglifier', '>= 1.0.3'
  gem 'uri-js-rails'
  gem 'turbolinks'
  gem 'jquery-ui-rails'
  gem 'bootstrap-datepicker-rails'
  gem 'bootstrap-select-rails'
end

group :test, :development do
  gem 'factory_girl_rails'
  gem 'pry-rails'
  gem 'hirb'
end

group :development do
  gem 'mail_view'
  gem 'bullet'
  gem 'capistrano'
  gem 'quiet_assets'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'awesome_print'
end

group :test do
  gem 'minitest-rails-capybara'
  gem 'turn'
  gem 'selenium-webdriver'
  gem 'chromedriver-helper'
  gem 'database_cleaner'
end
