require_relative '../test_helper'
require_relative '../../../lib/inspec-reporter-json-hdf/reporter'

class InspecPluginTest < Minitest::Test
  def test_that_reporter_exists
    refute_nil InspecPlugins::HdfReporter::Reporter
  end
end
