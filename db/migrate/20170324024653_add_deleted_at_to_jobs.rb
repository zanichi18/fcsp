class AddDeletedAtToJobs < ActiveRecord::Migration[5.0]
  def change
    add_column :jobs, :deleted_at, :datetime
    add_index :jobs, :deleted_at
  end
end
