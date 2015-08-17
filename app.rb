require 'rack/router'
require 'erb'

require_relative 'app/controllers/home'
require_relative 'app/controllers/signup'

class App

  Lotus::Controller.configure do
    # TODO: configure stuff here...
  end

  def call(env)
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

    router = Rack::Router.new do
      get '/' => home_index
      get '/signup' => signup_new
      post '/signup/create' => signup_create
      get '/signup/thanks' => signup_thanks
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
