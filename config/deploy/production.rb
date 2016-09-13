server 'bibliotecadeleter.com.ar', user: 'apps', roles: %w{app web db}

set :stage_name, 'production'
set :deploy_to, '/srv/http/bibliotecadeleter.com.ar'

# Cómo reiniciar passenger
set :passenger_restart_with_touch, true

set :default_env, {
  path: '~/.gem/ruby/2.3.0/bin:$PATH',
  gem_home: '~/.gem/ruby/2.3.0'
}
