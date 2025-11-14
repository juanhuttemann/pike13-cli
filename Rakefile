# frozen_string_literal: true

require "bundler/gem_tasks"
require "rspec/core/rake_task"
require "rubocop/rake_task"

RuboCop::RakeTask.new

RSpec::Core::RakeTask.new(:spec)

desc "Run console with pike13-cli loaded"
task :console do
  require_relative "lib/pike13/cli"
  require "irb"
  ARGV.clear
  IRB.start
end

desc "Build and install gem locally"
task :install_local do
  sh "gem build pike13-cli.gemspec"
  sh "gem install pike13-cli-#{Pike13::CLI::VERSION}.gem"
end

desc "Clean build artifacts"
task :clean do
  sh "rm -f pike13-cli-*.gem"
end

task default: %i[rubocop spec]
