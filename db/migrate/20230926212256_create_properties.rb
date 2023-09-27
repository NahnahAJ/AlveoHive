class CreateProperties < ActiveRecord::Migration[7.0]
  def change
    create_table :properties do |t|
      t.references :user, null: false, foreign_key: true
      t.references :category, null: false, foreign_key: true
      t.string :name
      t.string :location
      t.string :property_status
      t.text :images
      t.text :video
      t.text :property_overview
      t.integer :number_of_bedrooms
      t.integer :number_of_bathrooms
      t.decimal :ratings
      t.text :amenities
      t.string :furnishing
      t.decimal :size
      t.decimal :price
      t.date :date_listed

      t.timestamps
    end
  end
end
