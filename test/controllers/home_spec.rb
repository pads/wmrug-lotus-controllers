require 'minitest/spec'
require 'minitest/autorun'
require_relative '../../app/controllers/home'

describe Home do

  describe 'Show Action' do

    before do
      @action = Home::Show.new
    end

    it 'should return the message passed to it via params' do
      params = { message: 'Ben' }
      @action.call(params)

      @action.message.must_equal 'Ben'

      #TODO: This should work as it's an example in the docs?
      #@action.exposures.must_equal({ message: 'Ben' })
    end
  end
end
