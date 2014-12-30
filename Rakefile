require "bundler/gem_tasks"

require "rspec/core/rake_task"
RSpec::Core::RakeTask.new(:spec)

EXT_NAME = "open_jtalk"

if RUBY_PLATFORM =~ /java/
  require "rake/javaextensiontask"
  Rake::JavaExtensionTask.new EXT_NAME do |ext|
    ext.lib_dir = "lib/#{EXT_NAME}"
  end
else
  require "rake/extensiontask"
  Rake::ExtensionTask.new EXT_NAME do |ext|
    ext.lib_dir = "lib/#{EXT_NAME}"
  end
end
