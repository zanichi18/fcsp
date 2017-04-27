class CreateUserWorks < ActiveRecord::Migration[5.0]
  def change
    create_table :user_works do |t|
      t.string :position
      t.text :description
      t.integer :status
      t.date :start_time
      t.date :end_time
      t.references :user, foreign_key: true
      t.references :organization, foreign_key: true

      t.timestamps
    end
  end
end
