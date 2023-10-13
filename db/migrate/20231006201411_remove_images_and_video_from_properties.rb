class RemoveImagesAndVideoFromProperties < ActiveRecord::Migration[7.0]
  def change
    remove_column :properties, :images, :jsonb
    remove_column :properties, :video, :text
  end
end
