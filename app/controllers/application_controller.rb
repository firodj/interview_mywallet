class ApplicationController < ActionController::API
  before_action :set_default_response_format
  before_action :check_authorize_access

  class UserNotAuthorized < StandardError; end

  rescue_from UserNotAuthorized, with: :user_not_authorized

  attr_reader :current_user
  attr_reader :is_admin

  def authorize_admin_only
    raise UserNotAuthorized unless @is_admin
  end

  def authorize_user_only
    raise UserNotAuthorized unless @current_user
  end

  def authorize_only
    raise UserNotAuthorized unless @current_user || @is_admin
  end

  private
    def check_authorize_access
      headers = request.headers
      if headers['Authorization'].present?
        email = headers['Authorization'].split(' ').last
        @is_admin = email == 'system'
        @current_user = User.find_by(email: email)
      end
    end

    def user_not_authorized
      render json: { message: "You are not authorized to access this resource" }, status: :unauthorized
    end

    def unprocessable_entity(exception)
      render json: { message: exception.message }, status: :unprocessable_entity
    end

    def set_default_response_format
      request.format = :json
    end
end
