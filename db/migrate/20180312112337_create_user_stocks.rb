class CreateUserStocks < ActiveRecord::Migration[5.1]
  def change
    create_table :user_stocks do |t|
      t.references :user, index: true, foreign_key: true
      t.references :stock, index: true, foreign_key: true

      t.timestamps
    end
  end
end
