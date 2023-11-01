class CreateUserDetails < ActiveRecord::Migration[7.0]
  def change
    create_table :user_details do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name
      t.text :bio
      t.text :address
      t.string :country
      t.string :company_name
      t.string :mobile_phone
      t.string :office_phone

      t.timestamps
    end
  end
end
