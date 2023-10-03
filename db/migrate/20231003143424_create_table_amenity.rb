class CreateTableAmenity < ActiveRecord::Migration[7.0]
  def change
    create_table :amenities do |t|
      t.references :property, null: false, foreign_key: true
      t.boolean :fully_fitted_kitchen
      t.boolean :furnishing
      t.boolean :standby_generator
      t.boolean :internet_connectivity
      t.boolean :ac_rooms
      t.boolean :refridgerator
      t.boolean :cctv_camera
      t.boolean :washroom
      t.boolean :security_service
      t.boolean :tv
      t.boolean :gym
      t.string :others

      t.timestamps
    end
  end
end
