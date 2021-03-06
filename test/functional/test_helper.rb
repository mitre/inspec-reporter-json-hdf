require 'minitest/autorun'
require 'inspec-reporter-json-hdf'
require 'minitest/reporters'

reporter_options = { color: true, slow_count: 5 }
Minitest::Reporters.use! [Minitest::Reporters::SpecReporter.new(reporter_options)]
