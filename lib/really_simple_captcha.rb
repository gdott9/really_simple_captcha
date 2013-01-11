require "really_simple_captcha/version"

require "really_simple_captcha/util"
require "really_simple_captcha/captcha/reverse_captcha"
require "really_simple_captcha/captcha/plain_captcha"

module ReallySimpleCaptcha
end

require "really_simple_captcha/railtie" if defined?(Rails)
