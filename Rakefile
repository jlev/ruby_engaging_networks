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
require 'rake'

require 'jeweler'
require './lib/engaging_networks/version.rb'

Jeweler::Tasks.new do |gem|
  # gem is a Gem::Specification... see http://guides.rubygems.org/specification-reference/ for more options
  gem.name = "engaging_networks"
  gem.homepage = "http://github.com/jlev/engaging_networks"
  gem.license = "MIT"
  gem.summary = %Q{A wrapper for the Engaging Networks API}
  gem.description = %Q{Gem for interacting with the Engaging Networks API}
  gem.email = "josh@levinger.net"
  gem.authors = ["Josh Levinger", "Nathan Woodhull"]
  
  # dependencies defined in Gemfile
  gem.add_dependency 'vertebrae'
  gem.add_dependency 'json'
  gem.add_dependency 'activesupport'
  gem.add_dependency 'activemodel'

end
Jeweler::RubygemsDotOrgTasks.new

require 'rspec/core'
require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.pattern = FileList['spec/**/*_spec.rb']
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
  rdoc.title = "engaging_networks #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
