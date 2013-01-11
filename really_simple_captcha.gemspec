# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'really_simple_captcha/version'

Gem::Specification.new do |gem|
  gem.name          = "really_simple_captcha"
  gem.version       = ReallySimpleCaptcha::VERSION
  gem.authors       = ["Guillaume DOTT"]
  gem.email         = ["guillaume.dott@lafourmi-immo.com"]
  gem.description   = %q{Simple gem to add captcha or negative captcha to your Rails 3 application}
  gem.summary       = %q{TODO: Write a gem summary}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_runtime_dependency 'rmagick'
end
