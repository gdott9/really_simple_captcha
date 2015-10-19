module ReallySimpleCaptcha::Captcha
  module ReverseCaptcha
    include ActiveSupport::Configurable
    config_accessor :field_name

    config.field_name = :reverse_captcha

    def self.configure(&block)
      yield config
    end

    module ViewHelpers
      def reverse_captcha_tag
        content_tag :div, text_field_tag(ReverseCaptcha.field_name, nil, id: "reverse_captcha_#{Time.now.nsec}"), class: 'reverse_captcha', style: 'display: none'
      end
    end

    module ControllerHelpers
      def reverse_captcha_valid?
        params[ReverseCaptcha.field_name].blank?
      end
    end
  end
end
