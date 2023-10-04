class CreateCategories < ActiveRecord::Migration[7.0]
  def change
    create_table :categories do |t|
      t.string :name
      t.string :parent_category

      t.timestamps
    end
    add_index :categories, :name
  end
end
