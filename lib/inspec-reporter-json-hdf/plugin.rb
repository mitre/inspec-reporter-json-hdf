module InspecPlugins
  module HdfReporter
    class Plugin < Inspec.plugin(2)
      plugin_name :'inspec-reporter-json-hdf'

      reporter :hdf do
        require_relative 'reporter.rb'
        InspecPlugins::HdfReporter::Reporter
      end
    end
  end
end
