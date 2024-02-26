class AddPropertyTypeToProperties < ActiveRecord::Migration[7.0]
  def change
    add_column :properties, :property_type, :string
  end
end
