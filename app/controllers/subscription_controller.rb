# Controller for checking subscription status
class SubscriptionController < ApplicationController
  def subscribed
    user = User.find_by(id: params[:id])

    if user && user.subscribed?
      render json: { subscribed: true }
    else
      render json: { subscribed: false }
    end
  end
end
