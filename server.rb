# frozen_string_literal: true

ENV['PORT'] ||= "5100"
ENV['HOST'] ||= "localhost"
require 'iodine'

require 'sinatra'
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
  index({ isbn: 1 }, { unique: true, name: "isbn_index" })
end

# Endpoints
get '/' do
  'Welcome to BookList!'
end

# Handler: Sinatra
Iodine.listen service: :http, handler: Sinatra::Application
# For static file service, we only need a single worker and a single thread
Iodine.workers = 1 # negative value, will imply it to use half of your CPU cores
Iodine.threads = 1 # this value in opposite must be always positive
Iodine.verbosity = 5 # debugging
Iodine.start
