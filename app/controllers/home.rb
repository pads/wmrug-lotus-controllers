require 'lotus-controller'

module Home
  class Index
    include Lotus::Action

    def call(params)
      self.format = :html
      status 200, 'Hello world!'
    end
  end
end
