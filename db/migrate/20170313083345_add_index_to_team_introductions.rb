class AddIndexToTeamIntroductions < ActiveRecord::Migration[5.0]
  def change
    add_index :team_introductions, :team_target_id
    add_index :team_introductions, :team_target_type
  end
end
