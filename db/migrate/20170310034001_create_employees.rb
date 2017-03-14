class CreateEmployees < ActiveRecord::Migration[5.0]
  def change
    create_table :employees do |t|
      t.references :company
      t.references :user
      t.string :description
      t.date :start_time
      t.integer :role
      t.integer :status

      t.timestamps
    end
  end
end
