require 'rails_helper'

RSpec.describe WeatherFacade do
  describe 'class methods' do
    
    it 'can return current weather data' do
      VCR.use_cassette('weather_facade') do
        location = WeatherFacade.new('erie,co')
        weather = location.weather
        
        expect(weather).to be_a Weather
        expect(weather.current_weather).to be_a Hash
        expect(weather.current_weather).to have_key :last_updated
        expect(weather.current_weather).to have_key :temperature
        expect(weather.current_weather).to have_key :feels_like
        expect(weather.current_weather).to have_key :humidity
        expect(weather.current_weather).to have_key :uvi
        expect(weather.current_weather).to have_key :visibility
        expect(weather.current_weather).to have_key :conditions
        expect(weather.current_weather).to have_key :icon
      end
    end

    it 'can return daily weather data' do
      VCR.use_cassette('weather_facade') do
        location = WeatherFacade.new('erie,co')
        weather = location.weather

        expect(weather.daily_weather).to be_a Array
        expect(weather.daily_weather.first).to have_key :date
        expect(weather.daily_weather.first).to have_key :sunrise
        expect(weather.daily_weather.first).to have_key :sunset
        expect(weather.daily_weather.first).to have_key :max_temp
        expect(weather.daily_weather.first).to have_key :min_temp
        expect(weather.daily_weather.first).to have_key :conditions
        expect(weather.daily_weather.first).to have_key :icon
      end
    end

    it 'can return hourly weather data' do
      VCR.use_cassette('weather_facade') do
        location = WeatherFacade.new('erie,co')
        weather = location.weather

        expect(weather.hourly_weather).to be_a Array
        expect(weather.hourly_weather.first).to have_key :time
        expect(weather.hourly_weather.first).to have_key :temperature
        expect(weather.hourly_weather.first).to have_key :conditions
        expect(weather.hourly_weather.first).to have_key :icon
      end
    end
  end
end