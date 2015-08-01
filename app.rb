require 'sinatra/base'
require_relative 'app/controllers/home'

class App < Sinatra::Base

  get '/' do
    action = Home::Index.new
    action.call(params)
  end
end
