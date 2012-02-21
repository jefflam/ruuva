class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :description
      t.integer :collection_id
      t.datetime :date_time

      t.timestamps
    end
    add_index :events, :collection_id
    add_index :events, :date_time
  end
end
