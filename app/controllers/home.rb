require 'lotus-controller'

module Home
  class Index
    include Lotus::Action

    # Whitelist
    params do
      param :message
    end

    def initialize
      self.format = :html
    end

    def call(params)
      status 200, "Hello #{params[:message]}"
    end
  end
end
