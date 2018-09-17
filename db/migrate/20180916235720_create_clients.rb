class CreateClients < ActiveRecord::Migration[5.2]
  def change
    create_table :clients do |t|
      t.string :name, null: false, index: true
      t.string :identifier, null: false, index: true
      t.string :card, index: true

      t.timestamps
    end
  end
end
