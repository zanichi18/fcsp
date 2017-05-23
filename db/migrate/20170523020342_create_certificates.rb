class CreateCertificates < ActiveRecord::Migration[5.0]
  def change
    create_table :certificates do |t|
      t.string :name
      t.date :qualified_time
      t.string :qualified_organization
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
