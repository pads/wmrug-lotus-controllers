require 'rake/testtask'
require 'net/http'
require 'fileutils'

Rake::TestTask.new do |task|
  task.pattern = 'test/**/*_spec.rb'
end

task :setup do
  Net::HTTP.start('yui.yahooapis.com') do |http|
    response = http.get('/pure/0.6.0/pure-min.css')
    FileUtils.mkdir_p('public/css')
    open('public/css/pure-min.css', "w") { |file| file.write(response.body) }
  end
end
