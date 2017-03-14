class CreateEducationLearningPrograms < ActiveRecord::Migration[5.0]
  def change
    create_table :education_learning_programs do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
