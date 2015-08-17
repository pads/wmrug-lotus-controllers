require 'lotus/controller'
require 'json'

module Api
  module Users
    class Index
      include Lotus::Action
      accept :json

      def call(params)
        users = [
            { lotus_gem: 'lotus', name: 'Andy' },
            { lotus_gem: 'utils', name: 'Jon' },
            { lotus_gem: 'views', name: 'Rob' },
            { lotus_gem: 'model', name: 'Omar' },
            { lotus_gem: 'helpers', name: 'Adre' },
            { lotus_gem: 'controller', name: 'Ben' },
            { lotus_gem: 'router', name: 'Kevin' },
            { lotus_gem: 'validations', name: 'Matt' }
        ]

        status 200, JSON.generate(users: users)
      end
    end
  end
end
