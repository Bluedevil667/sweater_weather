require 'rails_helper'

RSpec.describe BookFacade do
  describe 'instance methods' do
    it 'can retrieve books' do
      book_facade = BookFacade.new('denver', 5)
      books = book_facade.books
      
      expect(books).to be_a Book
      expect(books.books).to be_an Array
      expect(books.total_books_found).to eq(100)
      expect(books.books.first).to be_a Hash
      expect(books.books.first).to have_key :isbn
      expect(books.books.first).to have_key :title
      expect(books.books.first).to have_key :publisher
      expect(books.destination).to eq('denver')
      expect(books.forecast).to be_a Hash
      expect(books.forecast).to have_key :summary
      expect(books.forecast).to have_key :temperature
    end
  end
end
