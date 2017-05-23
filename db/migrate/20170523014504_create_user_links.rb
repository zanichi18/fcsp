class CreateUserLinks < ActiveRecord::Migration[5.0]
  def change
    create_table :user_links do |t|
      t.string :link
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
