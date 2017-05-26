class CreateSocialNetworks < ActiveRecord::Migration[5.0]
  def change
    create_table :social_networks do |t|
      t.integer :social_network_type
      t.string :url
      t.references :owner, polymorphic: true

      t.timestamps
    end
  end
end
