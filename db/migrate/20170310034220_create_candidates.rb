class CreateCandidates < ActiveRecord::Migration[5.0]
  def change
    create_table :candidates do |t|
      t.references :user
      t.references :job
      t.integer :interested_in

      t.timestamps
    end
  end
end
