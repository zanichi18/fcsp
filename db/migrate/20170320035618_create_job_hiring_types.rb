class CreateJobHiringTypes < ActiveRecord::Migration[5.0]
  def change
    create_table :job_hiring_types do |t|
      t.references :job, foreign_key: true
      t.references :hiring_type, foreign_key: true

      t.timestamps
    end
  end
end
