class CreatePosts < ActiveRecord::Migration[5.0]
  def change
    create_table :posts do |t|
      t.string :title
      t.text :content
      t.integer :author_id
      t.integer :likes_count, default: 0
      t.integer :comments_count, default: 0
      t.references :postable, polymorphic: true

      t.timestamps
    end
  end
end
