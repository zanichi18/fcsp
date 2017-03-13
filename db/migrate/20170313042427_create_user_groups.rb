class CreateUserGroups < ActiveRecord::Migration[5.0]
  def change
    create_table :user_groups do |t|
      t.references :user, foreign_key: true
      t.references :group, foreign_key: true
      t.references :position, foreign_key: true
      t.boolean :is_default_group

      t.timestamps
    end
  end
end
