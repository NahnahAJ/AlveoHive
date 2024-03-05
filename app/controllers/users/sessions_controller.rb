# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
include RackSessionFix
  # TODO: remove the below in production
  skip_before_action :verify_authenticity_token, only: [:create]
  # before_action :configure_sign_in_params, only: [:create]
  before_action :authenticate_user!

  respond_to :json
  private

  def respond_with(resource, _opts = {})

  user_data = UserSerializer.new(resource).serializable_hash[:data][:attributes]
  user_detail = UserDetail.find_by(user_id: resource.id)

   additional_data = {
     id: resource.id,
     bio: user_detail&.bio,
     address: user_detail&.address,
     country: user_detail&.country,
     company_name: user_detail&.company_name,
     mobile_phone: user_detail&.mobile_phone,
     office_phone: user_detail&.office_phone,
     user_type: user_detail&.user_type,
   }

   # Check if subscribed and last subscription date is within the past year
   subscribed = user_detail&.subscription == 'subscribed' &&
   user_detail&.last_subscription_date&.to_date < 1.year.ago.to_date

   subscription_active = user_detail&.subscription == 'subscribed' &&
   user_detail&.last_subscription_date &&
   user_detail&.last_subscription_date > 1.year.ago

  render json: {
    status: {code: 200, message: 'Logged in successfully.'},
    data: user_data.merge(additional_data).merge(subscribed: subscription_active)
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