class CreateEducationPosts < ActiveRecord::Migration[5.0]
  def change
    create_table :education_posts do |t|
      t.string :title
      t.text :content
      t.integer :category_id
      t.references :user, foreign_key: true

      t.timestamps
    end

    add_foreign_key :education_posts, :education_categories, column: :category_id
  end
end
