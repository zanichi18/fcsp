class AddSchoolReferenceToUserEducations < ActiveRecord::Migration[5.0]
  def change
    remove_column :user_educations, :school
    add_reference :user_educations, :school, foreign_key: true
  end
end
