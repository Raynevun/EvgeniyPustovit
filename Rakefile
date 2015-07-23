task :default => [ :test, :app ]

require 'rake'
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:test) do
  'rspec spec/*'
end

task :app do
  ruby 'bin/exec.rb'
end