# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'cocoapods-static-frameworks/gem_version.rb'

Gem::Specification.new do |spec|
  spec.name          = 'cocoapods-static-frameworks'
  spec.version       = CocoapodsStaticFrameworks::VERSION
  spec.authors       = ['Stefan Pühringer']
  spec.email         = ['me@stefanpuehringer.com']
  spec.description   = %q{Build static instead of dynamic frameworks.}
  spec.summary       = %q{Build static instead of dynamic frameworks.}
  spec.homepage      = 'https://github.com/b-ray/cocoapods-static-frameworks'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'cocoapods', '1.3.1'

  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake'
end
