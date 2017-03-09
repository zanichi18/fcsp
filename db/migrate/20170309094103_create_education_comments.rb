class CreateEducationComments < ActiveRecord::Migration[5.0]
  def change
    create_table :education_comments do |t|
      t.references :user, foreign_key: true
      t.integer :project_id
      t.text :content

      t.timestamps
    end

    add_foreign_key :education_comments, :education_projects, column: :project_id
  end
end
