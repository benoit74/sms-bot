require 'twilio-ruby'

class IncomingSmsController < ApplicationController

    def create
        if !TwilioHelper.validate_request(ENV['TWILIO_AUTH_TOKEN'], request.original_url, request.request_parameters, request.headers["HTTP_X_TWILIO_SIGNATURE"])
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
        render xml:response.text, status: 401
    end

end
