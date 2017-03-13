class CreateEducationTrainings < ActiveRecord::Migration[5.0]
  def change
    create_table :education_trainings do |t|
      t.string :name
      t.text :description
      t.integer :technique_id

      t.timestamps
    end

    add_foreign_key :education_trainings, :education_techniques, column: :technique_id
  end
end
