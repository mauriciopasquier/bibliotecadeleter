server 'bibliotecadeleter.com.ar', user: 'apps', roles: %w{:app web db}

set :stage_name, 'production'
set :deploy_to, '/srv/http/bibliotecadeleter.com.ar'

set :default_env, {
  path: '~/.gem/ruby/2.2.0/bin:$PATH',
  gem_home: '~/.gem/ruby/2.2.0'
}
