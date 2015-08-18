require 'json'
require 'minitest/spec'
require 'minitest/autorun'
require_relative '../../../app/controllers/api/users'

describe Api do
  describe 'Users' do
    describe 'Index Action' do

      before do
        @action = Api::Users::Index.new
      end

      it 'should return a 200 response code' do
        response = @action.call({})
        response[0].must_equal 200
      end

      it 'should return a content type of application/json' do
        response = @action.call({ 'HTTP_ACCEPT' => 'application/json' })
        response[1]['Content-Type'].must_equal 'application/json; charset=utf-8'
      end

      it 'should return a list of users' do
        users = JSON.generate users: [
            { lotus_gem: 'lotus', name: 'Andy' },
            { lotus_gem: 'utils', name: 'Jon' },
            { lotus_gem: 'views', name: 'Rob' },
            { lotus_gem: 'model', name: 'Omar' },
            { lotus_gem: 'helpers', name: 'Adre' },
            { lotus_gem: 'controller', name: 'Ben' },
            { lotus_gem: 'router', name: 'Kevin' },
            { lotus_gem: 'validations', name: 'Matt' }
        ]

        response = @action.call({})
        response[2][0].must_equal users
      end

      it 'should return a 406 response code if the requested format is not JSON' do
        response = @action.call({ 'HTTP_ACCEPT' => 'text/html' })
        response[0].must_equal 406
      end
    end
  end
end
