require 'rake/testtask'
require File.expand_path('../lib/inspec-reporter-json-hdf/version', __FILE__)

Rake::TestTask.new(:test) do |t|
  t.libs << 'test'
  t.libs << 'lib'
  t.test_files = FileList['test/**/*_test.rb']
end
