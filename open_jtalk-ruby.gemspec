# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'open_jtalk/version'

Gem::Specification.new do |spec|
  spec.name          = "open_jtalk-ruby"
  spec.version       = OpenJtalk::VERSION
  spec.authors       = ["NAKANO Hideo"]
  spec.email         = ["pinarello.marvel@gmail.com"]
  spec.summary       = %q{Open JTalk Ruby}
  spec.description   = %q{Open JTalk is a japanese text synthesis. this gem is ruby bindings.}
  spec.homepage      = "https://github.com/sunny4381/open_jtalk-ruby"
  spec.license       = "BSD"
  spec.extensions    = %w[ext/open_jtalk/extconf.rb]

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 0"
  spec.add_runtime_dependency "lame", "~> 0"
end
