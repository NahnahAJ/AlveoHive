class CreateCurrencies < ActiveRecord::Migration[7.0]
  def change
    create_table :currencies do |t|
      t.string :name
      t.jsonb :conversion_rates

      t.timestamps
    end
  end
end
