class CreateArticles < ActiveRecord::Migration[7.0]
  def change
    create_table :articles do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title
      t.string :summary
      t.text :content
      t.string :image
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
