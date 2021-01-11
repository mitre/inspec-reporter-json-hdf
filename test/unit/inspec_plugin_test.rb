require_relative 'test_helper'

require 'inspec-reporter-json-hdf/version'

class InspecPluginVersionTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil InspecPlugins::HdfReporter::VERSION
  end
end