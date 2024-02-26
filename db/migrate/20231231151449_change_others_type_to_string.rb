class ChangeOthersTypeToString < ActiveRecord::Migration[7.0]
  def change
    change_column :amenities, :others, :string, using: 'others::text'
    change_column :public_facilities, :others, :string, using: 'others::text'
    change_column :recreational_facilities, :others, :string, using: 'others::text'

    execute <<-SQL
      ALTER TABLE amenities ALTER COLUMN others DROP NOT NULL;
      ALTER TABLE public_facilities ALTER COLUMN others DROP NOT NULL;
      ALTER TABLE recreational_facilities ALTER COLUMN others DROP NOT NULL;
    SQL
  end
end
