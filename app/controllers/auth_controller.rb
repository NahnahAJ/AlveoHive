# Controller for checking authentication status and subscription status
class AuthController < ApplicationController
    before_action :authenticate_user!, only: [:authenticated]
  
    def authenticated
      user_details = UserDetail.find_by(user_id: current_user.id)
  
      if user_details && user_details.subscription == 'subscribed' && user_details.last_subscription_date&.future?
        render json: { authenticated: true, user: current_user, subscribed: true, user_details: user_details }
      else
        render json: { authenticated: true, user: current_user, subscribed: false, user_details: user_details }
      end
    end
  end
  