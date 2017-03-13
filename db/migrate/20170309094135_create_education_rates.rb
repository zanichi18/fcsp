class CreateEducationRates < ActiveRecord::Migration[5.0]
  def change
    create_table :education_rates do |t|
      t.integer :rate
      t.references :user, foreign_key: true
      t.integer :project_id

      t.timestamps
    end

    add_foreign_key :education_rates, :education_projects, column: :project_id
  end
end
