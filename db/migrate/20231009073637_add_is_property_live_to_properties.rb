class AddIsPropertyLiveToProperties < ActiveRecord::Migration[7.0]
  def change
    add_column :properties, :is_property_live, :boolean, default: false
  end
end