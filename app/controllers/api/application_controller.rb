module Api
  class ApplicationController < ActionController::Base
    include ErrorRenderer
  
    # APIなのでCSRFの対策は不要
    protect_from_forgery with: :null_session
    skip_before_action :verify_authenticity_token
    before_action :authenticate
  
    rescue_from ActiveRecord::RecordInvalid, with: -> (e) { render_bad_request(Aroma::Error::ValidationError.convert(e)) }
    rescue_from WeakParameters::ValidationError, with: -> (e) { render_bad_request(Aroma::Error::ValidationError.convert(e)) }
    rescue_from Aroma::Error::AuthenticationFailed, with: -> (e) { render_unauthorized(e) }
    rescue_from Aroma::Error::UserBanned, with: -> (e) { render_unauthorized(e) }
    #rescue_from Aroma::Error::InvalidUserAroma, with: -> (e) { render_bad_request(e) }
    #rescue_from Aroma::Error::ConversationNotFound, with: -> (e) { render_not_found(e) }
    #rescue_from Aroma::Error::ConversationUserNotFound, with: -> (e) { render_not_found(e) }
  
    def authenticate
      raise Aroma::Error::AuthenticationFailed unless current_user.present?
      raise Aroma::Error::UserBanned if current_user.banned?
    end
  
    def custom_header
      @custom_header ||= Aroma::HTTPHeader.new(request.headers)
    end
  
    def current_user
      @current_user ||= User.fetch_by_token(custom_header.token) if custom_header.present?
    end
  end
end
