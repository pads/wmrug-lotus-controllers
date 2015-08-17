require 'lotus/controller'
require 'json'

module Api
  module Users
    class UserNotFound < StandardError
      def initialize(id)
        super "User with ID #{id} not found"
      end
    end

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

    class Show
      include Lotus::Action
      # Can be configured globally in the config
      #handle_exception ArgumentError => 400
      handle_exception ArgumentError => :handle_argument_error
      handle_exception UserNotFound => :handle_not_found_error

      def call(params)
        # Not using Lotus Router so have to access raw env
        id = params.env['rack.route_params'][:id].to_i
        raise ArgumentError unless id > 0

        users = []
        user = users[id]
        raise UserNotFound.new(id) unless user
      end

      private

      def handle_argument_error(exception)
        status 400, JSON.generate(error: 'Bad Request')
      end

      def handle_not_found_error(exception)
        status 404, JSON.generate(error: exception.message)
      end
    end
  end
end
