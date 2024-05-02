class CreatePropertyDetails < ActiveRecord::Migration[7.0]
  def change
    create_table :property_details do |t|
      t.references :property, null: false, foreign_key: true
      t.boolean :has_room_serviced, default: false
      t.integer :number_of_storeys
      t.boolean :pet_friendly_compound, default: false
      t.string :compound_finishing
      t.string :finishing
      t.string :bathroom_type_and_location
      t.string :year_built
      t.string :street
      t.string :payment_plan
      t.string :state_of_land
      t.string :number_of_tenants
      t.string :type_of_meter
      t.string :source_of_water
      t.boolean :property_needs_renovation, default: false
      t.boolean :smoking_allowed, default: false
      t.boolean :tiled_areas, default: false
      t.string :ceiling_type

      t.timestamps
    end
  end
end
