# coding: utf-8

Gem::Specification.new do |spec|
  spec.name          = "another_enum"
  spec.version       = "1.0.0"
  spec.authors       = ["Mike Williams"]
  spec.email         = ["mdub@dogbiscuit.org"]
  spec.summary       = %q{Support for defining enumerated types}
  spec.homepage      = "https://github.com/mdub/another_enum"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "rake", "~> 10.1"
  spec.add_development_dependency "rspec", "~> 2.14"

end
