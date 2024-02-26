class AddAdditionalAmenitiesToAmenities < ActiveRecord::Migration[7.0]
  def change
    add_column :amenities, :walled_gated, :boolean, default: false
    add_column :amenities, :parking_space, :boolean, default: false
    add_column :amenities, :living_room, :boolean, default: false
    add_column :amenities, :dining_room, :boolean, default: false
  end
end
