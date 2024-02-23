# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
include RackSessionFix
  # before_action :configure_sign_in_params, only: [:create]
  before_action :authenticate_user!

  respond_to :json
  private

  def respond_with(resource, _opts = {})
  render json: {
    status: {code: 200, message: 'Logged in sucessfully.'},
    data: UserSerializer.new(resource).serializable_hash[:data][:attributes]
  }, status: :ok
end

def respond_to_on_destroy
  if current_user
    render json: {
      status: {code: 200, message: 'Logged out sucessfully.'},
    }, status: :ok
  else
    render json: {
      status: {code: 401, message: 'User could not be found.'}
    }, status: :unauthorized
  end
end

end