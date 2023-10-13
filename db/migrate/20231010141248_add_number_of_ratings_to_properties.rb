class AddNumberOfRatingsToProperties < ActiveRecord::Migration[7.0]
  def change
    add_column :properties, :number_of_ratings, :integer, default: 0
  end
end
