# frozen_string_literal: true

require_relative '../spec_helper'

require './lib/server' # <-- sinatra app

RSpec.describe Book do
  before do
    described_class.create_indexes
    described_class.create(title: 'Foundation', author: 'Isaac Asimov', isbn: '0553293354')
    described_class.create(title: 'Dune', author: 'Frank Herbert', isbn: '0441172717')
    described_class.create(title: 'Hyperion (Hyperion Cantos)', author: 'Dan Simmons', isbn: '0553283685')
    Mongoid.client('default').collections.last.delete_one(isbn: '081298160X')
  end

  # It works without droping of the default client:
  # after do
  #   described_class.delete_all
  # end

  def app
    Sinatra::Application
  end

  let!(:uri) { '/api/v1/books' }
  let(:incomplete_json) { %({\"title\":\"The Power Of Habit\"}) }
  let(:invalid_json) { %({\"title\":\"The Power Of Habit\") }
  let(:valid_json) { %({\"title\":\"The Power Of Habit\", \"author\":\"Charles Duhigg\", \"isbn\":\"081298160X\"}) }
  let(:patch_json) { %({\"isbn\":\"0812981609\"}) }

  it 'loads all books' do
    get uri
    expect(last_response.body).to include('Simmons').or include('Herbert').or include('Asimov')
  end

  context 'when not found' do
    let!(:book_id) do
      get uri
      (0x4 + last_response.body.split("\"")[35].to_i(16)).to_s(16)
    end

    it 'is expected to respond with 404 (get)' do
      get "#{uri}/#{book_id}"
      expect(last_response.status).to be 404
    end

    it 'is expected to respond with 404 (patch)' do
      patch "#{uri}/#{book_id}", patch_json
      expect(last_response.status).to be 404
    end

    it 'is expected to respond with 404 (delete)' do
      delete "#{uri}/#{book_id}"
      expect(last_response.status).to be 404
    end
  end

  it 'loads book by id' do
    get uri
    book_id = last_response.body.split("\"")[3]
    get "#{uri}/#{book_id}"

    expect(last_response.body).to include('0553293354').or include('0441172717').or include('0553283685')
  end

  context 'when invalid' do
    it 'is expected to respond with 400' do
      header 'Content-Type', 'application/json'
      post uri, invalid_json
      expect(last_response.status).to be 400
    end
  end

  context 'when incomplete' do
    it 'is expected to respond with 422' do
      header 'Content-Type', 'application/json'
      post uri, incomplete_json

      expect(last_response.status).to be 422
    end
  end

  context 'when parameters valid' do
    before do
      header 'Content-Type', 'application/json'
      post uri, valid_json
    end

    it 'creates' do
      expect(last_response.status).to be 201
    end

    it 'updates' do
      patch_id = last_response.location.split('/').last

      patch "#{uri}/#{patch_id}", patch_json
      expect(last_response.status).to be 200
    end

    it 'deletes' do
      delete_id = last_response.location.split('/').last

      delete "#{uri}/#{delete_id}"
      expect(last_response.status).to be 204
    end
  end
end
