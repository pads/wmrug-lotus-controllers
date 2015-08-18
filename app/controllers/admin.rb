module Admin
  class Index
    include Lotus::Action
    accept :html
    before :check_authentication
    after :log_request

    def call(params)
      status 200, 'You should not see me'
    end

    private

    def is_authenticated?
      #true
      false
    end

    def check_authentication
      halt 401 unless is_authenticated?
    end

    def log_request
      puts 'GET: /admin'
    end
  end
end
