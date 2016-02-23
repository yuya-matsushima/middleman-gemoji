require 'bundler/gem_tasks'
require 'rake/testtask'

task default: [:test, :cucumber]

Rake::TestTask.new do |test|
  test.test_files = Dir['test/**/test_*.rb']
  test.verbose = true
end

desc 'cucumber test'
task :cucumber do
  sh 'cucumber --backtrace features/'
end
