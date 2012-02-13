class AddShopToUsers < ActiveRecord::Migration
  def change
    add_column :users, :shop, :boolean, default: false
  end
end
