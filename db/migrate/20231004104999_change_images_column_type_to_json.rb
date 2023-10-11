class ChangeImagesColumnTypeToJson < ActiveRecord::Migration[7.0]
  def up
    change_column :properties, :images, :json, using: 'images::json'
  end

  def down
    change_column :properties, :images, :text
  end
end
