class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.string :description
      t.string :price
      t.integer :likes
      t.integer :collection_id

      t.timestamps
    end
    add_index :products, [:collection_id, :created_at]
  end
end
