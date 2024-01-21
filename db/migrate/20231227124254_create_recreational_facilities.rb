class CreateRecreationalFacilities < ActiveRecord::Migration[7.0]
  def change
    create_table :recreational_facilities do |t|
      t.references :property, null: false, foreign_key: true
      t.boolean :restaurants, default: false
      t.boolean :pubs, default: false
      t.boolean :gyms, default: false
      t.text :others, array: true, default: []

      t.timestamps
    end
  end
end
