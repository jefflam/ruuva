class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.integer :date
      t.integer :time
      t.string :description
      t.integer :collection_id

      t.timestamps
    end
    add_index :events, :collection_id
  end
end
