class CreateTransactions < ActiveRecord::Migration[7.1]
  def change
    create_table :transactions do |t|
      t.references :from_wallet, null: false, foreign_key: { to_table: :wallets }
      t.references :to_wallet, null: false, foreign_key: { to_table: :wallets }
      t.decimal :amount, precision: 8, scale: 2

      t.timestamps
    end
  end
end
