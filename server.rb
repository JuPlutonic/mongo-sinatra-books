# frozen_string_literal: true

# For static microservice, we only need a single worker and a single thread
IODINE_WORKER_COUNT = 1 # negative value, will imply it to use half of your CPU cores
IODINE_THREAD_COUNT = 1 # this value in opposite must be always positive
IODINE_DEBUG_VERBOSITY = 4 # =default, don't bothering when work in pry-console
IODINE_APP_HANDLER = Sinatra::Application # not `App` -- Rackup file config.ru
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

Iodine.listen service: :http, handler: IODINE_APP_HANDLER
Iodine.workers = IODINE_WORKER_COUNT
Iodine.threads = IODINE_THREAD_COUNT
Iodine.verbosity = IODINE_DEBUG_VERBOSITY
Iodine.start
