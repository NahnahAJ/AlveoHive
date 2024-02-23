class SubscriptionWorker
    include Sidekiq::Worker
  
    def perform
      # Check and update subscriptions
      check_and_update_subscriptions
    end
  
    private
  
    def check_and_update_subscriptions
      expired_users = UserDetails.where("last_subscription_date >= ?", 1.year.ago)

      expired_users.each do |user_detail|
        user_detail.update(subscription: 'expired')
        # TODO: Send an email to notify the user about the expired subscription.
        # send_subscription_expired_email(user_detail)
      end
    end

  end
  