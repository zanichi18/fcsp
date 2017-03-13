class CreateAddresses < ActiveRecord::Migration[5.0]
  def change
    create_table :addresses do |t|
      t.references :company_id
      t.string :address
      t.float :longtitude
      t.float :latitude
      t.boolean :head_office

      t.timestamps
    end
  end
end
