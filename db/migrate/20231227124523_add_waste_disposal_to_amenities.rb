class AddWasteDisposalToAmenities < ActiveRecord::Migration[7.0]
  def change
    add_column :amenities, :waste_disposal, :boolean, default: false
  end
end
