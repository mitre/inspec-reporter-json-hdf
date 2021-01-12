# provide the version for the plugin
require 'git-version-bump'

module InspecPlugins
  module HdfReporter
    VERSION = GVB.version(false, true)
  end
end
