require 'lotus/controller'

module Signup
  class New
    include Lotus::Action
    expose :csrf_token

    def call(params)
      @csrf_token = Random.new_seed
    end
  end

  class Params < Lotus::Action::Params
    param :email, presence: true, format: /@/
    param :password, presence: true, confirmation: true
  end

  class Create
    include Lotus::Action
    params Params
    expose :csrf_token

    def call(params)
      if params.valid?
        redirect_to '/signup/thanks'
      else
        @csrf_token = Random.new_seed
      end
    end
  end

  class Thanks
    include Lotus::Action

    def call(params)
      status 200, '<h1>Thank You</h1><p>We will be in touch soon.</p>'
    end
  end
end
