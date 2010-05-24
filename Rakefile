require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "rack-flash-session"
    gem.summary = "Rack::FlashSession converts a session query parameter to a cookie if the request's user agent is flash"
    gem.description = <<-DESCRIPTION

Rack::FlashSession converts a session query parameter to a cookie if the request\'s user agent is flash.
http://github.com/bartt/rack-flash-session

DESCRIPTION
    gem.email = "<bart.teeuwisse@thecodemill.biz>"
    gem.homepage = "http://github.com/bartt/rack-flash-session"
    gem.authors = ["Bart Teeuwisse"]
    gem.files = "lib/**/*"

    gem.add_dependency 'rack', '>= 1.0'

    gem.add_development_dependency 'rack', '>=1.1'
    gem.add_development_dependency 'rack-test', '>=0.5.3'
    gem.add_development_dependency "rspec", ">= 1.3.0"
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: sudo gem install jeweler"
end

require 'spec/rake/spectask'
Spec::Rake::SpecTask.new(:spec) do |spec|
  spec.libs << 'lib' << 'spec'
  spec.spec_files = FileList['spec/**/*_spec.rb']
end

Spec::Rake::SpecTask.new(:rcov) do |spec|
  spec.libs << 'lib' << 'spec'
  spec.pattern = 'spec/**/*_spec.rb'
  spec.rcov = true
end

task :spec => :check_dependencies

task :default => :spec

begin
  require 'yard'
  YARD::Rake::YardocTask.new
rescue LoadError
  task :yardoc do
    abort "YARD is not available. In order to run yardoc, you must: sudo gem install yard"
  end
end
