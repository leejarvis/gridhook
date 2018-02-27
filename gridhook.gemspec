lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'gridhook/version'

Gem::Specification.new do |spec|
  spec.name          = 'gridhook'
  spec.version       = Gridhook::VERSION
  spec.authors       = ['Lee Jarvis']
  spec.email         = ['ljjarvis@gmail.com']
  spec.description   = 'A Rails engine to provide an endpoint for SendGrid webhooks'
  spec.summary       = 'A SendGrid webhook endpoint'
  spec.homepage      = 'https://github.com/injekt/gridhook'
  spec.license       = 'MIT'

  spec.required_ruby_version = Gem::Requirement.new('>= 1.9.2')

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['app', 'lib']

  spec.add_dependency 'rails', '>= 3.1.0'

  spec.add_development_dependency 'bundler', '~> 1.2'
  spec.add_development_dependency 'rake'
end
