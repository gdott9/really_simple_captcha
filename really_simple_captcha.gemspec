# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'really_simple_captcha/version'

Gem::Specification.new do |gem|
  gem.name          = "really_simple_captcha"
  gem.version       = ReallySimpleCaptcha::VERSION
  gem.authors       = ["Guillaume DOTT"]
  gem.email         = ["guillaume+github@dott.fr"]
  gem.summary       = %q{A really simple captcha gem}
  gem.description   = %q{Simple gem to add captcha or negative captcha to your Rails 3 application}
  gem.homepage      = "https://github.com/gdott9/really_simple_captcha"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_runtime_dependency 'rmagick'
  gem.add_runtime_dependency 'activesupport'
end
