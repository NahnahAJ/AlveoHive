# app/controllers/application_controller.rb

class ApplicationController < ActionController::API
  include ActionController::Cookies
  before_action :authorize_request

  def authorize_request
    @current_user = User.find_by(id: decode_token['user_id']) if token_present?
    render json: { error: 'Unauthorized' }, status: :unauthorized unless @current_user
  end

  def token_present?
    request.headers['Authorization'].present?
  end

  def decode_token
    JWT.decode(token, JWT_SECRET_KEY)[0] if token_present?
  rescue JWT::DecodeError
    {}
  end

  def token
    request.headers['Authorization'].split(' ')[1] if token_present?
  end
end
