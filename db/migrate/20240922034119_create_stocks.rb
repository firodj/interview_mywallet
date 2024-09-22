class CreateStocks < ActiveRecord::Migration[7.1]
  def change
    create_table :stocks do |t|
      t.string :name, index: { unique: true }
      t.string :company

      t.timestamps
    end
  end
end
