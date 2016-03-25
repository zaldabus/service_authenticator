# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'service_authenticator/version'

Gem::Specification.new do |spec|
  spec.name          = "service_authenticator"
  spec.version       = ServiceAuthenticator::VERSION
  spec.authors       = ["Ryan Beckman"]
  spec.email         = ["beckman.ryan@gmail.com"]

  spec.summary       = %q{Simple authentication between services.}
  spec.description   = %q{This allows for lightweight storage and authentication of API keys used between services.}
  spec.homepage      = "https://github.com/zaldabus/service_authenticator"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
end
