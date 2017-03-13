class CreateEducationTrainings < ActiveRecord::Migration[5.0]
  def change
    create_table :education_trainings do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
