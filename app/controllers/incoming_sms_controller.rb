require 'twilio-ruby'

class IncomingSmsController < ApplicationController

    def create
        respond_ok
    end

    # Create an empty response, and return status 200
    # Everything went as planned
    def respond_ok
        response = Twilio::TwiML::Response.new
        render xml:response.text, status: 200
    end
end
