# ReallySimpleCaptcha

ReallySimpleCaptcha is just another captcha gem.

## Requirements

- Rails >= 3
- RMagick

## Usage

### PlainCaptcha

The plain captcha display an image with distorted text and a text field.

To use it, add this line in the view file within the form tag :
```
<%= plain_captcha_tag %>
```

To verify the captcha in the controller, use :
```
plain_captcha_valid?
```

### ReverseCaptcha

The reverse captcha add a text field hidden with CSS to trick bot into filling this field.

To use it, add this line in the view file within the form tag :
```
<%= reverse_captcha_tag %>
```

To verify the captcha in the controller, use :
```
reverse_captcha_valid?
```

## Configuration

ReverseCaptcha and PlainCaptcha must be configured separately.

### PlainCaptcha
```
ReallySimpleCaptcha::Captcha::PlainCaptcha.configure do |config|
  config.text_length = 6

  # colors
  config.fill = 'darkblue'
  config.background_color = 'white'
  # font size
  config.pointsize = 22
  # image modification options
  config.implode_amount = 0.2
  config.wave_amplitude = 4.0
  config.wave_length = 60.0
end
```

### ReverseCaptcha
```
ReallySimpleCaptcha::Captcha::ReverseCaptcha.configure do |config|
  config.field_name = 'reverse_captcha'
end
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
