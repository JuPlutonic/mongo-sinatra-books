# frozen_string_literal: true

guard :rspec, cmd: 'bundle exec rspec', all_after_pass: true do
  require 'guard/rspec/dsl'
  dsl = Guard::RSpec::Dsl.new(self)

  # RSpec files
  rspec = dsl.rspec
  watch(rspec.spec_helper) { rspec.spec_dir }
  watch(rspec.spec_support) { rspec.spec_dir }
  watch(rspec.spec_files)
  # watch(%r{spec/factories/(.*)_factory.rb}) { |m| "spec/models/#{m[1]}_spec.rb" }

  # Ruby file
  watch('server.rb')
end

guard 'shotgun' do
  watch('server.rb')
  callback(:run_on_change_begin){ `overmind r -s "$(pwd)"/tmp/dev.sock mns_app` }
  callback(:run_on_change_begin){ `overmind r -s "$(pwd)"/tmp/dev.sock mns_app` }
end
