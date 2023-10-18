class AddCurrencyToProperties < ActiveRecord::Migration[7.0]
  def change
    add_column :properties, :currency, :string, default: 'GHS', null: false
    add_index :properties, :currency
  end
end
