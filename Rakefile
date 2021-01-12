require 'rake/testtask'
require File.expand_path('../lib/inspec-reporter-json-hdf/version', __FILE__)

Rake::TestTask.new(:unit) do |t|
  t.libs << 'test'
  t.libs << 'lib'
  t.test_files = FileList['test/unit/*_test.rb']
end

Rake::TestTask.new(:functional) do |t|
  t.libs << 'test'
  t.libs << 'lib'
  t.test_files = FileList['test/functional/*_test.rb']
end
