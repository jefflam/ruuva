class RenameImageColumnToProducts < ActiveRecord::Migration
  def change
  	rename_column(:products, :images, :product_image)
  end
end
