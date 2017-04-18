class AddProfileRequestsToJobs < ActiveRecord::Migration[5.0]
  def change
    add_column :jobs, :profile_requests, :string, null: false, default: "[]"
  end
end
