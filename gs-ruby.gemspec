# coding: utf-8
# frozen_string_literal: true
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'gs-ruby/version'

Gem::Specification.new do |spec|
  spec.name          = 'gs-ruby'
  spec.version       = GS::VERSION
  spec.authors       = ['Lawrance Shepstone']
  spec.email         = ['lawrance.shepstone@gmail.com']

  spec.summary       = 'GS-Ruby'
  spec.description   = 'Simple wrapper for the Ghostscript command'
  spec.homepage      = 'https://github.com/lshepstone/gs-ruby'
  spec.license       = 'MIT'

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.13'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rubocop', '~> 0'
  spec.add_development_dependency 'rubocop-rspec', '~> 0'
end
