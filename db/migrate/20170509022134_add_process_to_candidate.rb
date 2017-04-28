class AddProcessToCandidate < ActiveRecord::Migration[5.0]
  def change
    add_column :candidates, :process, :integer
  end
end
