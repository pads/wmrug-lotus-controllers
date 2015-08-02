require 'sinatra/base'
require_relative 'app/controllers/home'
require_relative 'app/controllers/signup'

class App < Sinatra::Base

  set :views, settings.root + '/app/views'

  get '/' do
    action = Home::Index.new
    action.call(params)
    erb :'home/index' , locals: action.exposures
  end

  get '/signup' do
    action = Signup::New.new
    action.call(params)
    erb :'signup/new', locals: action.exposures
  end

  post '/signup/create' do
    action = Signup::Create.new
    response = action.call(params)
    if action.errors.any?
      locals = action.exposures
      locals.merge!(errors: action.errors)
      erb :'signup/new', locals: locals
    else
      response
    end
  end

  get '/signup/thanks' do
    erb :'signup/thanks'
  end
end
