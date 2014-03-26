# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'patternlab/version'

Gem::Specification.new do |spec|
  spec.name          = "patternlab"
  spec.version       = Patternlab::VERSION
  spec.authors       = ["Jason Hanggi"]
  spec.email         = ["jason@tablexi.com"]
  spec.description   = %q{Patternlab}
  spec.summary       = %q{Patternlab}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_dependency "rake"
end
