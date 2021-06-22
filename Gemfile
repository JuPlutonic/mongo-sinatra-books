# frozen_string_literal: true

source 'https://rubygems.org'

ruby '2.7.3'

##==presentation tier http layer
# iodine - a fast HTTP / Websocket Server with Pub/Sub support, optimized for Ruby MRI on Linux / BSD (https://github.com/boazsegev/iodine)
gem 'iodine', '~>0.7'

##======logic tier http layer
# Classy web-development dressed in a DSL (http://sinatrarb.com/)
gem 'sinatra'

##======transport layer: sinatra/namespaces from
# Collection of useful Sinatra extensions (http://sinatrarb.com/contrib/)
gem 'sinatra-contrib'

##======persistance tier db layer
# Elegant Persistence in Ruby for MongoDB. (https://mongoid.org)
gem 'mongoid'

group :development do
  # C-x C-e to invoke an editor on the current pry (or irb) line (https://github.com/tpope/pry-editline)
  gem 'pry-editline', require: false, path: '~/optimiz/gems/pry-editline'
  # Guard gem for RSpec (https://github.com/guard/guard-rspec)
  gem 'guard-rspec', require: false
end

group :development, :test do
  # Loads environment variables from `.env`. (https://github.com/bkeepers/dotenv)
  gem 'dotenv', '~> 2.4'
  # Guard keeps an eye on your file modifications (http://guardgem.org)
  gem 'guard'
  # Shotgun-like Guard for Rack apps (http://github.com/rchampourlier/guard-shotgun)
  gem 'guard-shotgun'
  # Fast debugging with Pry. (https://github.com/deivid-rodriguez/pry-byebug)
  gem 'pry-byebug'
  # Walk the stack in a Pry session (https://github.com/pry/pry-stack_explorer)
  gem 'pry-stack_explorer'
  # Try to run with Guard or replace it with gem `guard-shotgun`, use newer gem 'shotgun', github: 'megothss/shotgun'
  # Reloading Rack development server (https://github.com/rtomayko/shotgun)
  # gem 'shotgun', platforms: :ruby
end

group :test do
  # Capybara aims to simplify the process of integration testing Rack applications, such as Rails, Sinatra or Merb (https://github.com/teamcapybara/capybara)
  # gem 'capybara'
  # Mocking and stubbing library (https://mocha.jamesmead.org)
  gem 'mocha'
  # Simple testing API built on Rack (http://github.com/rack-test/rack-test)
  gem 'rack-test'
  # rspec-3.9.0 (http://github.com/rspec)
  gem 'rspec'
  # Record your test suite's HTTP interactions and replay`em for fast, deterministic, accurate tests. (https://relishapp.com/vcr/vcr/docs)
  # gem 'vcr'
  # Library for stubbing HTTP requests in Ruby. (http://github.com/bblimke/webmock)
  gem 'webmock'
end
