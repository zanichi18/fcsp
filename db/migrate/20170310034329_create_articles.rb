class CreateArticles < ActiveRecord::Migration[5.0]
  def change
    create_table :articles do |t|
      t.references :company, index: true
      t.references :user
      t.string :title
      t.text :content

      t.timestamps
    end
    add_index :articles, :title
  end
end
