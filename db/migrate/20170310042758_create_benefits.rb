class CreateBenefits < ActiveRecord::Migration[5.0]
  def change
    create_table :benefits do |t|
      t.references :company
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
