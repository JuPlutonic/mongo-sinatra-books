# frozen_string_literal: true

ENV['PORT'] ||= '5100'
ENV['HOST'] ||= 'localhost'
require 'iodine'

require 'sinatra'
require 'sinatra/namespace'
require 'pry'
require 'mongoid'

# DB Setup
Mongoid.load! 'mongoid.config'

# Models
class Book
  include Mongoid::Document

  field :title, type: String
  field :author, type: String
  field :isbn, type: String

  validates :title, presence: true
  validates :author, presence: true
  validates :isbn, presence: true

  index({ title: 'text' })
  index({ isbn: 1 }, { unique: true, name: 'isbn_index' })

  scope :title, ->(title) { where(title: /^#{title}/) }
  scope :author, ->(author) { where(author: author) }
  scope :isbn, ->(isbn) { where(isbn: isbn) }
end

# Serializers
class BookSerializer
  def initialize(book)
    @book = book
  end

  # So, where aren't appear Mongo-relatad _id--{oid}'s
  def as_json(*)
    data = {
      id: @book.id.to_s,
      title: @book.title,
      author: @book.author,
      isbn: @book.isbn
    }

    data[:errors] = _nempty_ary if (_nempty_ary = @book.errors).any?
  end
end

# Endpoints
namespace '/api/v1' do
  before do
    content_type 'application/json'
  end

  get '/books' do
    books = Book.all

    %i[title isbn author].each do |filter|
      books = books.send(filter, params[filter]) if params[filter]
    end

    # We just change this from books.to_json to the following
    books.map { |book| BookSerializer.new(book) }.to_json
  end
end

# Handler: Sinatra
Iodine.listen service: :http, handler: Sinatra::Application
# For static file service, we only need a single worker and a single thread
Iodine.workers = 1 # negative value, will imply it to use half of your CPU cores
Iodine.threads = 1 # this value in opposite must be always positive
Iodine.verbosity = 5 # debugging
Iodine.start
