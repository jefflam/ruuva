class RemoveLikesFromProducts < ActiveRecord::Migration
  def change
  	remove_column :products, :likes, :integer
  end
end
