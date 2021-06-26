# frozen_string_literal: true

require 'rubygems'
ENV['RACK_ENV'] ||= 'test' # <-- Rack:Test

require 'dotenv'
Dotenv.load('.env.test')
require 'rack/test'
require 'webmock/rspec'
require 'mocha/api'

RSpec.configure do |config|
  # rspec-expectations config goes here. You can use an alternate
  # assertion/expectation library such as wrong or the stdlib/minitest
  # assertions if you prefer.
  config.expect_with :rspec do |expectations|
    # This option will default to `true` in RSpec 4. It makes the `description`
    # and `failure_message` of custom matchers include text for helper methods
    # defined using `chain`, e.g.:
    #     be_bigger_than(2).and_smaller_than(4).description
    #     # => "be bigger than 2 and smaller than 4"
    # ...rather than:
    #     # => "be bigger than 2"
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.include Rack::Test::Methods

  # rspec-mocks config goes here. You can use an alternate test double
  # library (such as bogus or mocha) by changing the `mock_with` option here.
  # https://mocha.jamesmead.org/
  config.mock_with :mocha
  config.include Mocha::API

  config.shared_context_metadata_behavior = :apply_to_host_groups

  config.before do
    Mongoid.purge!
  end
  # config.after :all do
  #   Mongoid.default_client # error -->.drop
  # end
end
