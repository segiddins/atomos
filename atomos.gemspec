# frozen_string_literal: true

Gem::Specification.new do |spec|
  spec.name          = 'atomos'
  spec.version       = File.read(File.expand_path('VERSION', __dir__))
  spec.authors       = ['Samuel Giddins']
  spec.email         = ['segiddins@segiddins.me']

  spec.summary       = 'A simple gem to atomically write files'
  spec.homepage      = 'https://github.com/segiddins/atomos'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.required_ruby_version = '>= 3.1'

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'mutant', '~> 0.12.4'
  spec.add_development_dependency 'mutant-rspec', '~> 0.12.4'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rubocop'
end
