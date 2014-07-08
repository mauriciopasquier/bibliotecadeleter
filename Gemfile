source 'https://rubygems.org'

gem 'rails', '4.0.1'

# Database
gem 'pg'
gem 'pg_search'
# Rama con un parche para que las join tables salgan ordenadas
gem 'yaml_db', github: 'mauriciopasquier/yaml_db', branch: 'order-join-tables'

# Model
gem 'attribute_normalizer', github: 'mdeering/attribute_normalizer'
gem 'inflections', require: 'inflections/es'
gem 'paperclip'
gem 'squeel'
gem 'amoeba'
gem 'loofah'
gem 'state_machine'
gem 'gravtastic'

# View
gem 'dynamic_form'
gem 'haml-rails'
gem 'draper'
gem 'kaminari', '0.14.1'
gem 'friendly_id'
gem 'ransack'
gem 'sitemap'
# 1.0.11 tiene mal las dependencias con Rails 4
gem 'rails3-jquery-autocomplete', github: 'mauriciopasquier/rails3-jquery-autocomplete'
gem 'awesome_nested_fields'
gem 'kramdown'
gem 'lazyload-rails'
gem 'prawn'

# Controller
gem 'responders'
gem 'has_scope'
gem 'jbuilder', '~> 1.2'


# Server
gem 'thin'
gem 'cache_digests'
gem 'libmemcached_store'
gem 'rack-protection'

# Autenticación/autorización
gem 'devise'
gem 'cancan'
gem 'merit'

# I18n
gem 'rails-i18n'
gem 'devise-i18n'
gem 'i18n_country_select'

gem 'forem', github: 'radar/forem', branch: 'rails4'

# Development
gem 'minitest-rails'

# Assets
gem 'sass-rails', '~> 4.0.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'jquery-rails'
gem 'bootstrap-sass-rails', '< 3.0.0'
gem 'therubyracer'
gem 'uglifier', '>= 1.3.0'
gem 'uri-js-rails'
gem 'turbolinks'
gem 'jquery-ui-rails'
gem 'bootstrap-datepicker-rails'
gem 'bootstrap-select-rails'
gem 'jquery-countdown-rails'
gem 'bootstrap-filestyle-rails'

group :test, :development do
  gem 'factory_girl_rails'
  gem 'pry-rails'
  gem 'hirb'
end

group :development do
  gem 'mail_view'
  gem 'bullet'
  gem 'capistrano', '~> 2'
  gem 'quiet_assets'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'awesome_print'
  gem 'ruby-graphviz'
end

group :test do
  gem 'minitest-rails-capybara'
  gem 'turn'
  gem 'selenium-webdriver'
  gem 'chromedriver-helper'
  gem 'database_cleaner'
end

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end
