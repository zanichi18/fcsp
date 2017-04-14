class CreateUserPortfolios < ActiveRecord::Migration[5.0]
  def change
    create_table :user_portfolios do |t|
      t.string :url
      t.string :title
      t.text :description
      t.date :time
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
