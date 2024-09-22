class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :email, unique: true
      t.references :team, null: true, foreign_key: true

      t.timestamps
    end
  end
end
