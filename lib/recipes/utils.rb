namespace :utils do
  desc 'Uploads a directory. Use from=local_dir to=remote_dir.'
  task :upload_dir do
    local = ENV['from']
    remote = ENV['to']
    upload("#{local}", "#{remote}")
  end

  desc 'Testear los stages'
  task :about do
    run "uname -a;cd #{current_path}; #{rake} about"
  end
end
