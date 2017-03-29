class CreateJobs < ActiveRecord::Migration[5.0]
  def change
    create_table :jobs do |t|
      t.references :company
      t.string :title
      t.string :describe
      t.integer :type_of_candidates, default: 0
      t.integer :who_can_apply, default: 0
      t.integer :status, default: 0

      t.timestamps
    end
    add_index :jobs, :title
  end
end
