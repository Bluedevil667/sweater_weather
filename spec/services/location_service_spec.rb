require 'rails_helper'

RSpec.describe LocationService do

  describe 'instance methods' do
    it 'can get_location' do
      VCR.use_cassette('denver_location_service') do
        denver = LocationService.new.get_location('denver,co')
        
        expect(denver).to be_a Hash
        expect(denver).to have_key :results
        expect(denver[:results][0][:locations][0][:latLng]).to have_key :lat
        expect(denver[:results][0][:locations][0][:latLng]).to have_key :lng
        expect(denver[:results][0][:locations][0][:latLng][:lat]).to be_a Float
        expect(denver[:results][0][:locations][0][:latLng][:lng]).to be_a Float
      end
    end
    it 'can return the directions between two locations' do
      VCR.use_cassette('crested_butte_to_denver_location_service') do
        cb_to_dv = LocationService.new.get_directions('crested butte, co', 'denver, co')

        expect(cb_to_dv).to be_a Hash
        expect(cb_to_dv).to have_key :route
        expect(cb_to_dv[:route]).to have_key :formattedTime
        expect(cb_to_dv[:route][:formattedTime]).to be_a String
        expect(cb_to_dv[:route][:locations][0][:latLng]).to have_key :lat
        expect(cb_to_dv[:route][:locations][0][:latLng][:lat]).to be_a Float
        expect(cb_to_dv[:route][:locations][0][:latLng]).to have_key :lng
        expect(cb_to_dv[:route][:locations][0][:latLng][:lng]).to be_a Float
        expect(cb_to_dv[:route][:locations][1][:latLng]).to have_key :lat
        expect(cb_to_dv[:route][:locations][1][:latLng][:lat]).to be_a Float
        expect(cb_to_dv[:route][:locations][1][:latLng]).to have_key :lng
        expect(cb_to_dv[:route][:locations][1][:latLng][:lng]).to be_a Float
      end
    end
  end
end