require './app.rb'
require 'rack/static'

use Rack::Static, :urls => ['/css'], :root => 'public'

run App.new
