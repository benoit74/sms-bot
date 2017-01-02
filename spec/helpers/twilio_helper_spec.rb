# Specs in this file have access to a helper object that includes
# the TwilioHelper. For example:
#
# describe TwilioHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe TwilioHelper, :type => :helper do
    describe "validates signature" do
        it "validates a correct signature" do
            # Get your Auth Token from https://www.twilio.com/console
            auth_token = '8e0c414bf112380b6f86b0f06d200ae8'

            url = 'https://mycompany.com/myapp.php?foo=1&bar=2'
            params = {
            'CallSid' => 'CA1234567890ABCDE',
            'Caller'  => '+14158675309',
            'Digits'  => '1234',
            'From'    => '+14158675309',
            'To'      => '+18005551212'
            }
            # The X-Twilio-Signature header attached to the request
            twilio_signature = 'UGyPwJZ04FuAq4ZF/etv08weZOo='
            expect(TwilioHelper.validate_params(auth_token, url, params, twilio_signature)).to eq(true)
        end
    end
end