class CreateAddresses < ActiveRecord::Migration[5.0]
  def change
    create_table :addresses do |t|
      t.references :company
      t.string :address
      t.float :longitude
      t.float :latitude
      t.boolean :head_office

      t.timestamps
    end
  end
end
