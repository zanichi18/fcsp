class AddInfoStatusForInfoUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :info_users, :info_statuses, :text
  end
end
