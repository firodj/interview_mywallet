class ApplicationController < ActionController::API
  class UserNotAuthorized < StandardError; end

  rescue_from UserNotAuthorized, with: :user_not_authorized
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from ActiveRecord::InvalidForeignKey, with: :server_error
  rescue_from ActionController::ParameterMissing, with: :param_error

  attr_reader :current_user
  attr_reader :is_admin

  def authorize_admin
    check_authorize_access
    raise UserNotAuthorized unless @is_admin
  end

  def authorize_user
    check_authorize_access
    raise UserNotAuthorized unless @current_user
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

    def record_not_found(exception)
      render json: { message: exception.message }, status: :not_found
    end

    def user_not_authorized
      render json: { message: "You are not authorized to access this resource" }, status: :unauthorized
    end

    def server_error(exception)
      render json: { :error => exception.message }, :status => :internal_server_error
    end

    def param_error(exception)
      render json: { :error => exception.message }, :status => :bad_request
    end
end
