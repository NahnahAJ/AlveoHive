class AddUserTypeToUserDetails < ActiveRecord::Migration[7.0]
  def change
    add_column :user_details, :user_type, :text
  end
end
