class AddCommercialPropertyTypeToProperties < ActiveRecord::Migration[7.0]
  def change
    add_column :properties, :commercial_property_type, :string
  end
end
