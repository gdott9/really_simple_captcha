module ReallySimpleCaptcha
  class Railtie < Rails::Railtie
    initializer "really_simple_captcha.include_captcha_helpers" do
      ActionView::Base.send :include, Captcha::PlainCaptcha::ViewHelpers
      ActionController::Base.send :include, Captcha::PlainCaptcha::ControllerHelpers

      ActionView::Base.send :include, Captcha::ReverseCaptcha::ViewHelpers
      ActionController::Base.send :include, Captcha::ReverseCaptcha::ControllerHelpers
    end
  end
end
