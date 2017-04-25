server 'bibliotecadeleter.com.ar', user: 'apps', roles: %w{app web db}

set :stage_name, 'production'
set :deploy_to, '/srv/http/bibliotecadeleter.com.ar'

# Cómo reiniciar passenger
set :passenger_restart_with_touch, true

set :default_env, {
  path: '/home/apps/.rbenv/versions/2.4.1/bin/:$PATH',
  gem_home: '/home/apps/.rbenv/versions/2.4.1/lib/ruby/gems/2.4.0'
}
