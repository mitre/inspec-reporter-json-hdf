lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'inspec-reporter-json-hdf/version'

Gem::Specification.new do |spec|
  spec.name          = 'inspec-reporter-json-hdf'
  spec.version       = InspecPlugins::HdfReporter::VERSION
  spec.authors       = ['Rony Xavier']
  spec.email         = ['rxavier@mitre.org']
  spec.summary       = 'InSpec Reporter plugin for Heimdall'
  spec.description   = 'InSpec Reporter plugin to report HDF formated JSON to be used with Heimdall.'
  spec.homepage      = 'https://github.com/mitre/inspec-reporter-json-hdf'
  spec.license       = 'Apache-2.0'
  spec.require_paths = ['lib']
  spec.files = Dir.glob('{{lib}/**/*,inspec-reporter-json-hdf.gemspec}').reject { |f| File.directory?(f) }

  spec.required_ruby_version = '>= 2.7', '< 3'

  spec.add_runtime_dependency 'ruh-roo', '~> 3.0.1'
  spec.add_runtime_dependency 'git-version-bump'

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'bundler-audit'
  spec.add_development_dependency 'codeclimate-test-reporter'
  spec.add_development_dependency 'minitest'
  spec.add_development_dependency 'minitest-reporters'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'simplecov'
  spec.add_development_dependency 'inspec'
end
