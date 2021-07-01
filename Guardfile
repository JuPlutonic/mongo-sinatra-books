# frozen_string_literal: true

guard :rspec, cmd: 'bundle exec rspec' do
  require 'guard/rspec/dsl'
  dsl = Guard::RSpec::Dsl.new(self)

  ruby = dsl.ruby
  dsl.watch_spec_files_for(ruby.lib_files)

  rspec = dsl.rspec
  watch(rspec.spec_helper) { rspec.spec_dir }
  watch(rspec.spec_files)
end

guard 'shotgun' do
  watch('lib/server.rb')
  callback(:run_on_change_begin){ `overmind r -s "$(pwd)"/tmp/dev.sock mns_app` }
  callback(:run_on_change_begin){ `overmind r -s "$(pwd)"/tmp/dev.sock mns_app` }
end
