class AddOthersToAmenities < ActiveRecord::Migration[7.0]
  def change
    add_column :amenities, :others_new, :jsonb, default: []
    
    Amenity.reset_column_information
    
    Amenity.find_each do |amenity|
      amenity.update!(others_new: amenity.others)
    end
    
    remove_column :amenities, :others
    rename_column :amenities, :others_new, :others
  end
end
