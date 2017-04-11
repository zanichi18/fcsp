class CreateUserEducations < ActiveRecord::Migration[5.0]
  def change
    create_table :user_educations do |t|
      t.string :school
      t.string :major
      t.date :graduation
      t.text :description
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
