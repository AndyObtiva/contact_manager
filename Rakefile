# encoding: utf-8

require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'glimmer/launcher'
require 'rake'
require 'juwelier'
Juwelier::Tasks.new do |gem|
  # gem is a Gem::Specification... see http://guides.rubygems.org/specification-reference/ for more options
  gem.name = "contact_manager"
  gem.homepage = "http://github.com/AndyObtiva/contact_manager"
  gem.license = "MIT"
  gem.summary = %Q{Contact Manager}
  gem.description = %Q{Contact Manager is a Glimmer DSL for SWT sample leveraging SQLite DB via ActiveRecord.}
  gem.email = "andy.am@gmail.com"
  gem.authors = ["Andy Maleh"]

  gem.files = Dir['VERSION', 'LICENSE.txt', 'app/**/*', 'bin/**/*', 'config/**/*', 'db/**/*', 'docs/**/*', 'fonts/**/*', 'icons/**/*', 'images/**/*', 'lib/**/*', 'script/**/*', 'sounds/**/*', 'vendor/**/*', 'videos/**/*']
  gem.require_paths = ['vendor', 'lib', 'app']
  gem.executables = ['contact_manager']
  # dependencies defined in Gemfile
end
Juwelier::RubygemsDotOrgTasks.new
require 'rspec/core'
require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.pattern = FileList['spec/**/*_spec.rb']
  spec.ruby_opts = [Glimmer::Launcher.jruby_os_specific_options]
end

desc "Code coverage detail"
task :simplecov do
  ENV['COVERAGE'] = "true"
  Rake::Task['spec'].execute
end

task :default => :spec

require 'rdoc/task'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "contact_manager #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

require 'glimmer/rake_task'
Glimmer::RakeTask::Package.jpackage_extra_args =
  " --name 'Contact Manager'" +
  " --description 'Contact Manager'"
  # You can add more options from https://docs.oracle.com/en/java/javase/16/jpackage/packaging-tool-user-guide.pdf
