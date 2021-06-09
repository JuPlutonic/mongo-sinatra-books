# guard :rspec, cmd: './bin/rspec', all_after_pass: true do
#   require "guard/rspec/dsl"
#   dsl = Guard::RSpec::Dsl.new(self)

#   # Feel free to open issues for suggestions and improvements

#   # RSpec files
#   rspec = dsl.rspec
#   watch(rspec.spec_helper) { rspec.spec_dir }
#   watch(rspec.spec_support) { rspec.spec_dir }
#   watch(rspec.spec_files)
#   watch(%r{^views/.+\.erb$}) { |v| "spec/views/#{v[1]}_spec.rb" }
#   # watch(%r{spec/factories/(.*)_factory.rb}) { |m| "spec/models/#{m[1]}_spec.rb" }

#   # Ruby files
#   ruby = dsl.ruby
#   dsl.watch_spec_files_for(ruby.lib_files)
# end

guard 'shotgun' do
  watch('server.rb')
  callback(:run_on_change_begin){ `overmind r -s "$(pwd)"/tmp/dev.sock app` }
  callback(:run_on_change_begin){ `overmind r -s "$(pwd)"/tmp/dev.sock app` }
end
