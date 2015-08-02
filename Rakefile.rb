require 'rake/testtask'

Rake::TestTask.new do |task|
  task.pattern = 'test/**/*_spec.rb'
end
