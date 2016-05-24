Gem::Specification.new do |spec|
  spec.name          = "poloniex"
  spec.version       = "1.0.3"
  spec.authors       = ["Carl Schwope"]
  spec.email         = ["schwope.carl@gmail.com"]
  spec.description   = %q{Provides a wrapper for poloniex.com api}
  spec.summary       = %q{Provides a wrapper for poloniex.com api}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"

  spec.add_dependency 'rest-client'
  spec.add_dependency 'addressable'

end
