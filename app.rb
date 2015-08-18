require 'rack/router'
require 'lotus/controller'
require 'erb'

require_relative 'app/controllers/admin'
require_relative 'app/controllers/home'
require_relative 'app/controllers/signup'
require_relative 'app/controllers/api/users'

class App

  Lotus::Controller.configure do
    # TODO: not honouring this?
    default_format :json
  end

  def call(env)

    # HTML Client Routes

    admin_index = lambda do |env|
      action = Admin::Index.new
      action.call(env)
    end

    home_index = lambda do |env|
      action = Home::Show.new
      response = action.call(env)
      @message = action.exposures[:message]
      render response, 'home/index'
    end

    signup_new = lambda do |env|
      action = Signup::New.new
      response = action.call(env)
      @csrf_token = action.exposures[:csrf_token]
      render response, 'signup/new'
    end

    signup_create = lambda do |env|
      action = Signup::Create.new
      response = action.call(env)
      if action.errors.any?
        @csrf_token = action.exposures[:csrf_token]
        @errors = action.errors
        render response, 'signup/new'
      else
        response
      end
    end

    signup_thanks = lambda do |env|
      action = Signup::Thanks.new
      action.call(env)
    end

    # API Client Routes

    api_users_index = lambda do |env|
      action = Api::Users::Index.new
      action.call(env)
    end

    api_users_show = lambda do |env|
      action = Api::Users::Show.new
      action.call(env)
    end

    # Router Setup

    router = Rack::Router.new do

      # HTML Client Routes

      get '/' => home_index
      get '/admin' => admin_index
      get '/signup' => signup_new
      post '/signup/create' => signup_create
      get '/signup/thanks' => signup_thanks

      # JSON Client Routes

      get '/api/users' => api_users_index
      get '/api/users/:id' => api_users_show

    end

    router.call(env)
  end

  private

  def erb(template)
    path = File.expand_path("../app/views/#{template}.erb", __FILE__)
    ERB.new(File.read(path)).result(binding)
  end

  def render(response, template)
    [response[0], response[1], [erb(template)]]
  end
end
