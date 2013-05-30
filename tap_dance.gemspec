# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'tap_dance/version'

Gem::Specification.new do |spec|
  spec.name          = "tap_dance"
  spec.version       = TapDance::VERSION
  spec.authors       = ["Jonathan Martin"]
  spec.email         = ["me@nybblr.com"]
  spec.description   = %q{Manage your OSX binaries on a per project and system basis. Powered by Homebrew, inspired by Bundler.}
  spec.summary       = %q{Homebrew rocks, but managing system level dependencies can become a pain to track across multiple machines. Bundler was designed to make explicit declaration of Ruby dependencies consistent and painless. TapDance aims to do the same for system binaries.}
  spec.homepage      = "https://github.com/nybblr/tap_dance"
  spec.license       = "MIT"

  spec.required_ruby_version = '>= 1.8.7'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib", "ext"]

  spec.add_dependency "thor"
  spec.add_dependency "open4"

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "guard"
  spec.add_development_dependency "guard-rspec"
end
