# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
include RackSessionFix
  before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]
  respond_to :json

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:firstname, :lastname, :role])
  end  
  
  private

  def respond_with(resource, _opts = {})
  if request.method == "POST" && resource.persisted?
    render json: {
      status: {code: 200, message: 'Signed up sucessfully.'},
      data: UserSerializer.new(resource).serializable_hash[:data][:attributes]
    }, status: :ok
  elsif request.method == "DELETE"
    render json: {
      status: {code: 200, message: 'User account deleted sucessfully.'}
    }, status: :ok
  else
    render json: {
      status: {code: 422, message: "User could not be created successfully. #{resource.errors.full_messages.to_sentence}"}
    }, status: :unprocessable_entity
  end
end

end
