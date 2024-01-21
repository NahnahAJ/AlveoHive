class CreatePublicFacilities < ActiveRecord::Migration[7.0]
  def change
    create_table :public_facilities do |t|
      t.references :property, null: false, foreign_key: true
      t.boolean :schools, default: false
      t.boolean :hospitals, default: false
      t.boolean :pharmacies, default: false
      t.text :others, array: true, default: []

      t.timestamps
    end
  end
end
