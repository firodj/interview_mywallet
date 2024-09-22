class CreateStocks < ActiveRecord::Migration[7.1]
  def change
    create_table :stocks do |t|
      t.string :name, unique: true
      t.string :company

      t.timestamps
    end
    add_index :stocks, :name, unique: true
  end
end
