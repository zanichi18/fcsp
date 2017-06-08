class AddShareableIdAndShareableTypeAtToShareJobs < ActiveRecord::Migration[5.0]
  def change
    remove_column :share_jobs, :job_id
    add_column :share_jobs, :shareable_id, :integer
    add_column :share_jobs, :shareable_type, :string
    add_index :share_jobs, :shareable_id
  end
end
