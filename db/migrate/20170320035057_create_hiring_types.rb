class CreateHiringTypes < ActiveRecord::Migration[5.0]
  def change
    create_table :hiring_types do |t|
      t.string :name
      t.text :description
      t.integer :status

      t.timestamps
    end
  end
end
