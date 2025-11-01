# frozen_string_literal: true

require_relative 'lib/aasm_rbs/version'

Gem::Specification.new do |spec|
  spec.name = 'aasm_rbs'
  spec.version = AasmRbs::VERSION
  spec.summary = 'RBS signatures for AASM classes'
  spec.description = 'Easily generate RBS signatures for all the AASM automatically generated methods and constants of your ruby classes.'
  spec.license = 'MIT'

  spec.required_ruby_version = '>= 3.2.0'

  spec.author = 'Lorenzo Zabot'
  spec.email = ['lorenzozabot@gmail.com']
  spec.homepage = 'https://github.com/Uaitt/aasm_rbs'

  spec.metadata = {
    'allowed_push_host' => 'https://rubygems.org',
    'homepage_uri' => spec.homepage,
    'source_code_uri' => spec.homepage,
    'rubygems_mfa_required' => 'true'
  }

  spec.files = Dir['exe/**', 'lib/**/*.rb', 'sig/**/*.rbs', 'LICENSE', 'README.md']
  spec.require_paths = ['lib']
  spec.executables = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.bindir = 'exe'

  spec.add_dependency 'aasm', '~> 5'
end
