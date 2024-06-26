class Users::PasswordController < Devise::PasswordsController
  skip_before_action :verify_authenticity_token
  # PUT /resource/password
  def update
    self.resource = resource_class.reset_password_by_token(resource_params)
    yield resource if block_given?

    if resource.errors.empty?
      resource.unlock_access! if unlockable?(resource)
      flash_message = resource.active_for_authentication? ? :updated : :updated_not_active
      set_flash_message!(:notice, flash_message)
      sign_in(resource_name, resource)
      render json: { message: 'Password updated successfully.' }, status: :ok
    else
      set_minimum_password_length
      respond_with resource
    end
  end

  # POST /resource/password
  def create
    self.resource = resource_class.send_reset_password_instructions(resource_params)
    yield resource if block_given?

    if successfully_sent?(resource)
      render json: { message: 'Reset password instructions sent successfully.' }, status: :ok
    else
      respond_with(resource, status: :unprocessable_entity)
    end
  end
end
