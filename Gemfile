source 'https://rubygems.org'

gem 'rails', '3.2.9'

# Database
gem 'pg'

# Models
gem 'attribute_normalizer'

# Server
gem 'thin'

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
  gem 'turn', require: false   # Pretty printed test output
  gem 'factory_girl_rails'
end
