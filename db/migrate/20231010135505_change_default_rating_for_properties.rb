class ChangeDefaultRatingForProperties < ActiveRecord::Migration[7.0]
  def change
    change_column_default :properties, :ratings, 0.0
  end
end
