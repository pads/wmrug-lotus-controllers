require 'sinatra/base'
require_relative 'app/controllers/home'

class App < Sinatra::Base

  set :views, settings.root + '/app/views'

  get '/' do
    action = Home::Index.new
    action.call(params)
    erb :'home/index' , locals: action.exposures
  end
end
