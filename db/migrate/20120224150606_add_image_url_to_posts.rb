class AddImageUrlToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :image_url, :string
    add_index :posts, :image_url
  end
end
