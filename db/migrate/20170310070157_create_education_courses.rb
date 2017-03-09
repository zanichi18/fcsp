class CreateEducationCourses < ActiveRecord::Migration[5.0]
  def change
    create_table :education_courses do |t|
      t.text :detail
      t.integer :training_id
      t.datetime :start_date
      t.datetime :end_date

      t.timestamps
    end

    add_foreign_key :education_courses, :education_trainings, column: :training_id
  end
end
