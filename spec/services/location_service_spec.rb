require 'rails_helper'

RSpec.describe LocationService do

  describe 'instance methods' do
    it 'can get_location' do
      locationservice = LocationService.new
      locationresult = locationservice.get_location('denver,co')

      expect(locationresult).to be_a Hash
      expect(locationresult).to have_key :results
      expect(locationresult[:results][0][:locations][0][:latLng]).to have_key :lat
      expect(locationresult[:results][0][:locations][0][:latLng]).to have_key :lng
      expect(locationresult[:results][0][:locations][0][:latLng][:lat]).to be_a Float
      expect(locationresult[:results][0][:locations][0][:latLng][:lng]).to be_a Float
    end
  end
end