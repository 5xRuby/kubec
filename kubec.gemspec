# frozen_string_literal: true

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'kubec/version'

Gem::Specification.new do |spec|
  spec.name          = 'kubec'
  spec.version       = Kubec::VERSION
  spec.authors       = %w[5xRuby Aotokitsuruya]
  spec.email         = %w[rubygems@5xruby.tw contact@frost.tw]

  spec.summary       = 'Kubec is a utility for generate kubernetes config ' \
                       'and deploy.'
  spec.description   = 'Kubec is a utility for generate kubernetes config ' \
                       'and deploy.'
  spec.homepage      = 'https://kubec.5xruby.tw'

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'colorize'
  spec.add_dependency 'hirb'
  spec.add_dependency 'rake', '>= 10.0'

  spec.add_development_dependency 'bundler', '~> 1.16'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rubocop', '~> 0.49.0'
  spec.add_development_dependency 'overcommit'
  spec.add_development_dependency 'simplecov'
end
