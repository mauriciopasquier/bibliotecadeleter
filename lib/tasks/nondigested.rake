# Every time assets:precompile is called, trigger nondigested compilation afterwards.
Rake::Task['assets:precompile'].enhance do
  Rake::Task['assets:nondigested'].invoke
end

namespace :assets do
  # https://github.com/team-umlaut/umlaut/blob/5edcc609389edf833a79caa6f3ef92982312f0c5/lib/tasks/umlaut_asset_compile.rake
  desc 'Compila una versión sin digest de los assets'
  task :nondigested => :environment do
    asset_path = Rails.root.join 'public', Rails.configuration.assets.prefix.gsub('/', '')

    # This seems to be basically how ordinary asset precompile is logging, ugh.
    logger = Logger.new($stderr)

    manifest_path = Dir.glob(File.join(asset_path, 'manifest-*.json')).first
    manifest_data = JSON.load(File.new(manifest_path))

    manifest_data['assets'].each do |logical_path, digested_path|
      logical_pathname = Pathname.new logical_path

      if Rails.configuration.nondigested_assets.any? { |testpath| logical_pathname.fnmatch?(testpath, File::FNM_PATHNAME) }
        full_digested_path    = File.join(asset_path, digested_path)
        full_nondigested_path = File.join(asset_path, logical_path)

        logger.info "Copying to #{full_nondigested_path}"

        # Use FileUtils.copy_file with true third argument to copy
        # file attributes (eg mtime) too, as opposed to FileUtils.cp
        # Making symlnks with FileUtils.ln_s would be another option, not
        # sure if it would have unexpected issues.
        FileUtils.copy_file full_digested_path, full_nondigested_path, true
      end
    end
  end
end
