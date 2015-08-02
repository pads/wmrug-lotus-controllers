require 'lotus-controller'

module Home
  class Index
    include Lotus::Action
    expose :message

    # Whitelist
    params do
      param :message
    end

    def call(params)
      @message = params[:message]
    end
  end
end
