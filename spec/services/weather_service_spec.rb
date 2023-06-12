require 'rails_helper'

RSpec.describe WeatherService do

  describe 'instance methods' do
    it 'can get_weather' do
      weatherservice = WeatherService.new
      weatherresult = weatherservice.get_weather(39.738453, -104.984853)
      
      expect(weatherresult).to be_a Hash
    end
  end
end