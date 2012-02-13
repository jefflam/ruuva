class AddIndexToCollections < ActiveRecord::Migration
  def change
  	  	add_index :collections, [:user_id, :created_at]
  end
end
