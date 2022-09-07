require 'rake'
require 'rake/testtask'
require 'rdoc/task'
require 'cucumber/rake/task'

Cucumber::Rake::Task.new do |t|
  t.cucumber_opts = "--format pretty"
end

desc 'Default: run unit tests.'
task :default => :test

desc 'Test the word search generator.'
Rake::TestTask.new(:test) do |t|
  t.libs << 'lib'
  t.pattern = 'test/**/test_*.rb'
  t.verbose = true
end

desc "Open an irb session preloaded with this library"
task :console do
  sh "irb -r ./lib/word_search.rb"
end