class CreateArticles < ActiveRecord::Migration[5.0]
  def change
    create_table :articles do |t|
      t.references :company_id, index: true
      t.references :user_id
      t.string :title
      t.text :content

      t.timestamps
    end
    add_index :articles, :title
  end
end
