# Adaptadas de https://gist.github.com/157958
namespace :db do
  desc 'Create production database'
  task :create do
    run "cd #{current_path}; #{rake} db:create"
  end

  desc 'Populates the production database'
  task :seed do
    run "cd #{current_path}; #{rake} db:seed"
  end

  desc 'Sets up the production database'
  task :setup do
    run "cd #{current_path}; #{rake} db:setup"
  end

  desc 'Resets the production database'
  task :reset do
    run "cd #{current_path}; #{rake} db:reset"
  end
end
