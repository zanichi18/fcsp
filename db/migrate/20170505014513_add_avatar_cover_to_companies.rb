class AddAvatarCoverToCompanies < ActiveRecord::Migration[5.0]
  def change
    add_column :companies, :avatar_id, :integer
    add_column :companies, :cover_image_id, :integer
  end
end
