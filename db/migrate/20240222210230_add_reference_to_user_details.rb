class AddReferenceToUserDetails < ActiveRecord::Migration[7.0]
  def change
    add_column :user_details, :reference, :string
  end
end
