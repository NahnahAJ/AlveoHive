class AddDefaultValuesToLatitudeAndLongitude < ActiveRecord::Migration[7.0]
  def change
    change_column_default :properties, :latitude, from: nil, to: 0.0
    change_column_default :properties, :longitude, from: nil, to: 0.0
  end
end
