class AddHitsCountToProperties < ActiveRecord::Migration[7.0]
  def change
    add_column :properties, :hits_count, :integer, default: 0
  end
end
