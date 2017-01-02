require 'twilio-ruby'
require 'open-uri'
require "net/http"
require "uri"
require 'digest'
require 'openssl'

class IncomingSmsController < ApplicationController

    def create
        if !TwilioHelper.validate_request(request)
            logger.info "Invalid request received"
            respond_nok
            return
        else
            logger.info "Valid twilio request received"
        end
           
        begin
            file = open('http://' + ENV['SFR_BOX_IP'], :read_timeout => 1)
        rescue OpenURI::HTTPError => the_error
            logger.info "Application failed to connect to the SFR Box"
            respond_nok
            return
        end
        contents = file.read
        if !SfrBoxHelper.isCorrectNetwork(contents)
            logger.info "Application is not connected to the right network"
            respond_nok
            return
        else
            logger.info "Application is connected to the right network and SFR box is available"
        end



        uri = URI.parse('http://' + ENV['SFR_BOX_IP'] + '/login')

        http = Net::HTTP.new(uri.host, uri.port)

        request = Net::HTTP::Post.new(uri.request_uri)
        request.add_field("X-Requested-With", "XMLHttpRequest")
        request.set_form_data({"action" => "challenge"})

        response = http.request(request)

        if !response.kind_of? Net::HTTPSuccess
            logger.info "Failed to request challenge for login"
            respond_nok
            return
        end

        challenge = response.body[/.*<challenge>(.*)<\/challenge>/,1]

        if !challenge
            logger.info "Failed to find challenge in reply\n" + response.body
            respond_nok
            return
        end
        
        sfr_box_login_hash = Digest::SHA256.hexdigest ENV["SFR_BOX_LOGIN"]
        sfr_box_password_hash = Digest::SHA256.hexdigest ENV["SFR_BOX_PASSWORD"]

        digest  = OpenSSL::Digest::Digest.new('sha256')
        hash_1 = OpenSSL::HMAC.hexdigest(digest, challenge, sfr_box_login_hash)
        hash_2 = OpenSSL::HMAC.hexdigest(digest, challenge, sfr_box_password_hash)

        hash = hash_1 + hash_2
        
        request = Net::HTTP::Post.new(uri.request_uri)
        request.add_field("Cookie", "sid="+challenge)
        request.set_form_data({
            "method" => "passwd",
            "zsid" => challenge,
            "hash" => hash,
            "login" => "",
            "password" => ""})

        response = http.request(request)

        if !response.kind_of? Net::HTTPFound
            logger.info "Failed to login into SFR Box"
            respond_nok
            return
        end

        respond_ok
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
