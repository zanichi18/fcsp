class AddTeamToJob < ActiveRecord::Migration[5.0]
  def change
    add_reference :jobs, :team, foreign_key: true
  end
end
