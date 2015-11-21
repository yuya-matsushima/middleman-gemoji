# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'middleman-gemoji/version'

Gem::Specification.new do |spec|
  spec.name          = "middleman-gemoji"
  spec.version       = Middleman::Gemoji::VERSION
  spec.authors       = ["Yuya Terajima"]
  spec.email         = ["terra@e2esound.com"]
  spec.summary       = %q{Github-flavored emoji plugin for Middleman.}
  spec.description   = %q{Github-flavored emoji plugin for Middleman.}
  spec.homepage      = "https://github.com/yterajima/middleman-gemoji"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.required_ruby_version = '>= 2.0.0'

  spec.add_runtime_dependency "middleman", "~> 3.3"
  spec.add_runtime_dependency "gemoji", "~> 2.1"

  spec.add_development_dependency "cucumber", "~> 1.3"
  spec.add_development_dependency "aruba", "~> 0.6"
  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake", "~> 10"
  spec.add_development_dependency "slim", "~> 3.0"
  spec.add_development_dependency "minitest", "> 5.8"
end
