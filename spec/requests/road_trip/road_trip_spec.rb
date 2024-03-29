require 'rails_helper'

RSpec.describe 'Road Trip API' do
  describe 'Happy Path Testing' do
    it 'can return desired data for a road trip post request' do
      VCR.use_cassette('cb_to_denver_roadtrip_weather', allow_playback_repeats: true) do
        frozen_time = Time.new(2023, 6, 14, 12, 0, 0, '+00:00')
        Timecop.freeze(frozen_time) do

          user = create(:user)
          
          trip_params = {
            origin: 'crested butte, co',
            destination: 'denver, co',
            api_key: user.api_key
          }
          
          headers = {"CONTENT_TYPE" => "application/json"}
          post "/api/v1/road_trip", headers: headers, params: JSON.generate(trip_params)
          
          expect(response).to be_successful
          expect(response.status).to eq(200)
          
          trip = JSON.parse(response.body, symbolize_names: true)
          
          expect(trip).to be_a Hash
          expect(trip).to have_key :data
          expect(trip[:data]).to be_a Hash
          expect(trip[:data]).to have_key :id
          expect(trip[:data][:id]).to eq(nil)
          expect(trip[:data]).to have_key :type
          expect(trip[:data][:type]).to eq('road_trip')
          expect(trip[:data]).to have_key :attributes
          expect(trip[:data][:attributes]).to be_a Hash
          expect(trip[:data][:attributes]).to have_key :start_city
          expect(trip[:data][:attributes][:start_city]).to eq(trip_params[:origin])
          expect(trip[:data][:attributes]).to have_key :end_city
          expect(trip[:data][:attributes][:end_city]).to eq(trip_params[:destination])
          expect(trip[:data][:attributes]).to have_key :travel_time
          expect(trip[:data][:attributes][:travel_time]).to be_a String
          expect(trip[:data][:attributes]).to have_key :weather_at_eta
          expect(trip[:data][:attributes][:weather_at_eta]).to be_a Hash
          expect(trip[:data][:attributes][:weather_at_eta]).to have_key :datetime
          expect(trip[:data][:attributes][:weather_at_eta][:datetime]).to be_a String
          expect(trip[:data][:attributes][:weather_at_eta]).to have_key :temperature
          expect(trip[:data][:attributes][:weather_at_eta][:temperature]).to be_a Float
          expect(trip[:data][:attributes][:weather_at_eta]).to have_key :conditions
          expect(trip[:data][:attributes][:weather_at_eta][:conditions]).to be_a String
        end
      end
    end
  end

  describe 'Sad Path Testing' do
    it 'returns error if road trip is impossible' do
      VCR.use_cassette('impossible_trip_2', allow_playback_repeats: true) do
        user = create(:user)
          
        trip_params = {
          origin: 'crested butte, co',
          destination: 'paris, fr',
          api_key: user.api_key
        }
        
        headers = {"CONTENT_TYPE" => "application/json"}
        post "/api/v1/road_trip", headers: headers, params: JSON.generate(trip_params)

        expect(response).to be_successful
        expect(response.status).to eq(200)

        bad_trip = JSON.parse(response.body, symbolize_names: true)

        expect(bad_trip).to be_a Hash
        expect(bad_trip).to have_key :data
        expect(bad_trip[:data]).to be_a Hash
        expect(bad_trip[:data]).to have_key :id
        expect(bad_trip[:data][:id]).to eq(nil)
        expect(bad_trip[:data]).to have_key :type
        expect(bad_trip[:data][:type]).to eq('road_trip')
        expect(bad_trip[:data]).to have_key :attributes
        expect(bad_trip[:data][:attributes]).to be_a Hash
        expect(bad_trip[:data][:attributes]).to have_key :start_city
        expect(bad_trip[:data][:attributes][:start_city]).to eq(trip_params[:origin])
        expect(bad_trip[:data][:attributes]).to have_key :end_city
        expect(bad_trip[:data][:attributes][:end_city]).to eq(trip_params[:destination])
        expect(bad_trip[:data][:attributes]).to have_key :travel_time
        expect(bad_trip[:data][:attributes][:travel_time]).to eq('impossible')
        expect(bad_trip[:data][:attributes]).to have_key :weather_at_eta
        expect(bad_trip[:data][:attributes][:weather_at_eta]).to eq({})
      end
    end

    it 'returns error if the api key is empty' do
      trip_params = {
        origin: 'crested butte, co',
        destination: 'denver, co',
        api_key: ''
      }
      
      headers = {"CONTENT_TYPE" => "application/json"}
      post "/api/v1/road_trip", headers: headers, params: JSON.generate(trip_params)

      expect(response).to_not be_successful
      expect(response.status).to eq(401)

      error = JSON.parse(response.body, symbolize_names: true)

      expect(error).to be_a Hash
      expect(error).to have_key :errors
      expect(error[:errors]).to be_a Array
      expect(error[:errors][0]).to be_a Hash
      expect(error[:errors][0]).to have_key :detail
      expect(error[:errors][0][:detail]).to eq("API key is invalid")
    end

    it 'returns error if the api key is not valid' do
      trip_params = {
        origin: 'crested butte, co',
        destination: 'denver, co',
        api_key: '123abc'
      }
      
      headers = {"CONTENT_TYPE" => "application/json"}
      post "/api/v1/road_trip", headers: headers, params: JSON.generate(trip_params)

      expect(response).to_not be_successful
      expect(response.status).to eq(401)

      error = JSON.parse(response.body, symbolize_names: true)

      expect(error).to be_a Hash
      expect(error).to have_key :errors
      expect(error[:errors]).to be_a Array
      expect(error[:errors][0]).to be_a Hash
      expect(error[:errors][0]).to have_key :detail
      expect(error[:errors][0][:detail]).to eq("API key is invalid")
    end
  end
end