class CreateEducationAbouts < ActiveRecord::Migration[5.0]
  def change
    create_table :education_abouts do |t|
      t.string :title
      t.text :content

      t.timestamps
    end
  end
end
