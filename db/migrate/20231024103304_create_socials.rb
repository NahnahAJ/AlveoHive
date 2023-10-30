class CreateSocials < ActiveRecord::Migration[7.0]
  def change
    create_table :socials do |t|
      t.string :instagram
      t.string :facebook
      t.string :twitter
      t.string :linkedin
      t.string :whatsapp

      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end
