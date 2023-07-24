# frozen_string_literal: true

require_relative 'lib/aasm_rbs/version'

Gem::Specification.new do |spec|
  spec.name = 'aasm-rbs'
  spec.version = AasmRbs::VERSION
  spec.summary = 'AASM RBS'
  spec.description = 'Easily generate RBS signatures for all the Ruby classes that implement a state-machine with AASM'
  spec.license = 'MIT'

  spec.required_ruby_version = '>= 3.0.0'

  spec.author = 'Lorenzo Zabot'
  spec.email = ['lorenzozabot@gmail.com']
  spec.homepage = 'https://github.com/Uaitt/aasm-rbs'

  spec.metadata = {
    'allowed_push_host' => 'https://rubygems.org',
    'homepage_uri' => spec.homepage,
    'source_code_uri' => spec.homepage,
    'rubygems_mfa_required' => 'true'
  }

  spec.files = Dir['lib/**/*', 'LICENSE', 'README.md']
  spec.require_paths = ['lib']
  spec.executables = 'exe/aasm_rbs'
  spec.bindir = 'exe'

  spec.add_runtime_dependency 'aasm', '~> 5'
end
