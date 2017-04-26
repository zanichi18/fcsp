class AddIndexToCandidate < ActiveRecord::Migration[5.0]
  def change
    add_index :candidates, [:user_id, :job_id], unique: true
  end
end
