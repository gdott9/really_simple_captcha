require 'RMagick'
require 'base64'

module ReallySimpleCaptcha::Captcha
  module PlainCaptcha
    include ActiveSupport::Configurable
    config_accessor :field_name

    config_accessor :implode_amount
    config_accessor :wave_amplitude
    config_accessor :wave_length
    config_accessor :pointsize
    config_accessor :fill
    config_accessor :background_color
    config_accessor :text_length

    config.field_name = :plain_captcha
    config.text_length = 6

    def self.configure(&block)
      yield config
    end

    module ViewHelpers
      def plain_captcha_tag
        session[PlainCaptcha.field_name] = ReallySimpleCaptcha::Util.random_string(PlainCaptcha.text_length)

        image = PlainCaptcha.generate_image(session[:plain_captcha], {
          implode_amount: PlainCaptcha.implode_amount,
          wave_amplitude: PlainCaptcha.wave_amplitude,
          wave_length: PlainCaptcha.wave_length,
          pointsize: PlainCaptcha.pointsize,
          fill: PlainCaptcha.fill,
          background_color: PlainCaptcha.background_color,
        })

        content_tag :div, class: 'plain_captcha' do
          html = image_tag "data:image/gif;base64,#{image}", alt: "Captcha"
          html.concat text_field_tag PlainCaptcha.field_name, nil, required: 'required', autocomplete: 'off'

          html
        end
      end
    end

    module ControllerHelpers
      def plain_captcha_valid?
        res = params[PlainCaptcha.field_name] == session[PlainCaptcha.field_name]
        session[PlainCaptcha.field_name] = nil

        res
      end
    end

    def self.generate_image(captcha_text, args={})
      wave_amplitude = args[:wave_amplitude] || 4.0
      wave_length = args[:wave_length] || 60.0
      implode_amount = args[:implode_amount] || 0.2

      pointsize = args[:pointsize] || 22
      text_fill = args[:fill] || 'darkblue'

      background_color = args[:background_color] || 'white'

      image = ::Magick::Image.new(120, 40) do
        self.background_color = background_color
      end

      text = ::Magick::Draw.new do
        self.pointsize = pointsize
        self.gravity = ::Magick::CenterGravity
        self.fill = text_fill
      end

      text.annotate(image, 0, 0, 0, 0, captcha_text)

      image = image.wave(wave_amplitude, wave_length).implode(implode_amount)

      Base64.strict_encode64(image.to_blob { self.format = 'GIF' })
    end
  end
end
