class CreateEducationProjects < ActiveRecord::Migration[5.0]
  def change
    create_table :education_projects do |t|
      t.string :name
      t.text :description
      t.text :core_features
      t.string :git_repo
      t.text :release_note
      t.string :server_info
      t.string :pm_url
      t.boolean :is_project
      t.string :plat_form

      t.timestamps
    end
  end
end
