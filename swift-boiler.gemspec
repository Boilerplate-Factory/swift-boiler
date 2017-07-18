# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'swift/boiler/version'

Gem::Specification.new do |spec|
  spec.name          = "swift-boiler"
  spec.version       = Swift::Boiler::VERSION
  spec.authors       = ["Pedro Peres"]
  spec.email         = ["pedro.peres@weightwatchers.com"]

  spec.summary       = %q{This gem generate swift boilter plate code}
  spec.description   = %q{Swift-Boiler is a tool developed for iOS developers to speed up the process of implementing views, models, controllers, and many other common patterns found in an iOS project. Inspired by the swift syntax and the simplicity of the Rails generate tool, Swift-Boiler is a simple to use boiler plate code generator that will get you up running in no time.}
  spec.homepage      = "https://github.com/Boilerplate-Factory/swift-boiler"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = Dir["{bin,lib}/**/**/**/**", "LICENSE", "README.md"]
  spec.bindir        = "bin"
  spec.executables   = ["swift-boil"]
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.12"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
  spec.add_dependency "mustache", "~> 1.0.3"
end
