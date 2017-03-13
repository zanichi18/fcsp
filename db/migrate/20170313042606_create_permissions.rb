class CreatePermissions < ActiveRecord::Migration[5.0]
  def change
    create_table :permissions do |t|
      t.string :entry
      t.text :optional
      t.references :group, foreign_key: true

      t.timestamps
    end
  end
end
