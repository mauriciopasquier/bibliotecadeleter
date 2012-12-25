source 'https://rubygems.org'

gem 'rails', '3.2.9'

# Database
gem 'pg'

# Models
gem 'attribute_normalizer'
gem 'inflections'

# Server
gem 'thin'

# Autenticación/autorización
gem 'devise'

# I18n
gem 'rails-i18n'
gem 'devise-i18n'

group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'jquery-rails'
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
