class CreateMovements < ActiveRecord::Migration[5.2]
  def change
    create_table :movements do |t|
      t.references :client, null: false
      t.references :user, null: false
      t.decimal :amount, precision: 15, scale: 2, default: 0.0
      t.integer :kind, limit: 1, default: Movement.kinds[:credit]

      t.timestamps
    end
  end
end
