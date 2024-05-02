class AddLastSubscriptionDateToUserDetails < ActiveRecord::Migration[7.0]
  def change
    add_column :user_details, :last_subscription_date, :datetime, default: nil
  end
end
