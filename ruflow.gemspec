
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "ruflow/version"

Gem::Specification.new do |spec|
  spec.name          = "ruflow"
  spec.version       = Ruflow::VERSION
  spec.authors       = ["victor95pc"]
  spec.email         = ["victorpalomocastro@gmail.com"]

  spec.summary       = %q{Create flow-based programs using Ruby.}
  spec.description   = %q{Framework to create flow-based programs using Ruby.}
  spec.homepage      = "https://github.com/victor95pc/ruflow"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = %w(ruflow)
  spec.require_paths = ["lib"]

  spec.add_dependency "configurations", "~> 2.2.0"
  spec.add_dependency "thor",           "~> 0.20.0"
  spec.add_dependency "require_all",    "~> 1.5.0"

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "byebug"
end
