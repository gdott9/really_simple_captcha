require 'rmagick'
require 'base64'

module ReallySimpleCaptcha::Captcha
  module PlainCaptcha
    DEFAULT_OPTIONS = {
      width: 120,
      height: 40,
      wave_amplitude: 4.0,
      wave_length: 60.0,
      implode_amount: 0.3,
      pointsize: 22,
      text_fill: 'darkblue',
      background_color: 'white'
    }

    include ActiveSupport::Configurable
    config_accessor :field_name

    config_accessor :width
    config_accessor :height

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

        image = PlainCaptcha.generate_image(session[:plain_captcha],
                                            PlainCaptcha.config.select { |k,v| DEFAULT_OPTIONS.has_key?(k) })

        content_tag :div, class: 'plain_captcha' do
          html = image_tag "data:image/gif;base64,#{image}", alt: "Captcha"
          html.concat text_field_tag PlainCaptcha.field_name, nil, required: 'required', autocomplete: 'off'

          html
        end
      end
    end

    module ControllerHelpers
      def plain_captcha_valid?
        return true if Rails.env.test?

        res = params[PlainCaptcha.field_name] == session[PlainCaptcha.field_name]
        session[PlainCaptcha.field_name] = nil

        res
      end
    end

    def self.generate_image(captcha_text, args={})
      options = DEFAULT_OPTIONS.merge(args)

      image = ::Magick::Image.new(options[:width], options[:height]) do
        self.background_color = options[:background_color]
      end

      text = ::Magick::Draw.new do
        self.pointsize = options[:pointsize]
        self.gravity = ::Magick::CenterGravity
        self.fill = options[:text_fill]
      end

      text.annotate(image, 0, 0, 0, 0, captcha_text)

      image = image.implode(options[:implode_amount]).wave(options[:wave_amplitude], options[:wave_length])

      Base64.strict_encode64(image.to_blob { self.format = 'GIF' })
    end
  end
end
