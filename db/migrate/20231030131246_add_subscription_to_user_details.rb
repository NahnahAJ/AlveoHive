class AddSubscriptionToUserDetails < ActiveRecord::Migration[7.0]
  def change
    add_column :user_details, :subscription, :string
  end
end
