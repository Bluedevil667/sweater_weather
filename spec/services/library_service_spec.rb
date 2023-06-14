require 'rails_helper'

RSpec.describe LibraryService do
  describe 'instance methods' do
    xit 'can get_books' do
      library_service = LibraryService.new
      library_result = library_service.get_books('denver')
      
      expect(library_result).to be_a Hash
      expect(library_result).to have_key :docs
      expect(library_result[:docs].count).to eq(100)
      expect(library_result[:docs][0]).to have_key :title
      expect(library_result[:docs][0]).to have_key :author_name
      expect(library_result[:docs][0]).to have_key :first_publish_year
      expect(library_result[:docs][0]).to have_key :isbn
      expect(library_result[:docs][0]).to have_key :publisher
      expect(library_result[:docs][0]).to have_key :key
      expect(library_result[:docs][0][:title]).to be_a String
    end
  end
end
