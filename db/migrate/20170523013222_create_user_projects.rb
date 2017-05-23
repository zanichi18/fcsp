class CreateUserProjects < ActiveRecord::Migration[5.0]
  def change
    create_table :user_projects do |t|
      t.string :title
      t.string :url
      t.text :description
      t.date :start_date
      t.date :end_date
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
