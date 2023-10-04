class RemoveAmenitiesFromProperties < ActiveRecord::Migration[7.0]
  def change
    remove_column :properties, :amenities, :text
  end
end
