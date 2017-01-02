require 'twilio-ruby'

module TwilioHelper


=begin
# Get your Auth Token from https://www.twilio.com/console
auth_token = 'your_auth_token'

url = 'https://mycompany.com/myapp.php?foo=1&bar=2'
params = {
  'CallSid' => 'CA1234567890ABCDE',
  'Caller'  => '+14158675309',
  'Digits'  => '1234',
  'From'    => '+14158675309',
  'To'      => '+18005551212'
}
# The X-Twilio-Signature header attached to the request
twilio_signature = 'RSOYDt4T1cUTdK1PDd93/VVr8B8='
=end

    def TwilioHelper.validate_request(auth_token, url, params, signature)
        validator = Twilio::Util::RequestValidator.new(auth_token)
        return validator.validate(url, params, signature)
    end

end