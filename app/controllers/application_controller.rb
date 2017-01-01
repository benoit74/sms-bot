class ApplicationController < ActionController::Base
  protect_from_forgery unless: -> { hasTwilioHeader }, with: :exception

  private

  def hasTwilioHeader
    return request.headers["HTTP_X_TWILIO_SIGNATURE"] 
  end
end
