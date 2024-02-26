class RemoveCategoryIdFromProperties < ActiveRecord::Migration[7.0]
  def change
    remove_column :properties, :category_id, :integer
  end
end
