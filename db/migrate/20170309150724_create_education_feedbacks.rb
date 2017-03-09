class CreateEducationFeedbacks < ActiveRecord::Migration[5.0]
  def change
    create_table :education_feedbacks do |t|
      t.string :name
      t.string :email
      t.text :content
      t.integer :project_id

      t.timestamps
    end

    add_foreign_key :education_feedbacks, :education_projects, column: :project_id
  end
end
