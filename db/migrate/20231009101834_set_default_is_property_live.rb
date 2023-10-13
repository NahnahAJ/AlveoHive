class SetDefaultIsPropertyLive < ActiveRecord::Migration[7.0]
  def change
    change_column_default :properties, :is_property_live, from: nil, to: false
  end
end
