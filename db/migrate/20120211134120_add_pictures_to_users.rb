class AddPicturesToUsers < ActiveRecord::Migration
  def change
    add_column :users, :avatar, :string

    add_column :users, :cover_photo, :string

  end
end
