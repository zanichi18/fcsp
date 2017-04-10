class CreateJobSkills < ActiveRecord::Migration[5.0]
  def change
    create_table :job_skills do |t|
      t.references :job
      t.references :skill

      t.timestamps
    end
  end
end
