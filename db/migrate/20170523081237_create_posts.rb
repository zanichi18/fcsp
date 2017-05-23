class CreatePosts < ActiveRecord::Migration[5.0]
  def change
    create_table :posts do |t|
      t.string :title
      t.text :content
      t.integer :author_id
      t.references :postable, polymorphic: true

      t.timestamps
    end
  end
end
