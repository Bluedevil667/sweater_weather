require 'rails_helper'

RSpec.describe Book do
  it 'exists and has attributes' do
    book_data = {
      destination: 'denver,co',
      forecast: {
        summary: 'Light rain',
        temperature: 52.9
      },
      total_books_found: 100,
      books: [
        {
          isbn: [
            '9781338310536',
            '1338310534'
          ],
          title: 'The Bad Guys in the Baddest Day Ever',
          publisher: [
            'Scholastic Inc.'
          ]
        },
        {
          isbn: [
            '9781338596007',
            '133859600X'
          ],
          title: 'The Bad Guys in the Baddest Day Ever',
          publisher: [
            'Scholastic Inc.'
          ]
        }
      ]
    }
    book = Book.new(book_data)

    expect(book).to be_a Book
    expect(book.destination).to eq('denver,co')
    expect(book.forecast).to be_a Hash
    expect(book.forecast).to have_key :summary
    expect(book.forecast).to have_key :temperature
    expect(book.total_books_found).to eq(100)
    expect(book.books).to be_an Array
    expect(book.books.count).to eq(2)
    expect(book.books.first).to be_a Hash
    expect(book.books.first).to have_key :isbn
    expect(book.books.first).to have_key :title
    expect(book.books.first).to have_key :publisher
  end
end