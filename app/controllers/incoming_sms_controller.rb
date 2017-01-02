require 'twilio-ruby'

class IncomingSmsController < ApplicationController

    def create
        if !TwilioHelper.validate_request(request)
            respond_nok
        else
            respond_ok
        end
    end

    # Create an empty response, and return status 200
    # Everything went as planned
    def respond_ok
        response = Twilio::TwiML::Response.new
        render xml:response.text, status: 200
    end

    # Create an empty response, and return status 403
    # Something went wront
    def respond_nok
        response = Twilio::TwiML::Response.new
        render plain:nil, status: 401
    end

end
