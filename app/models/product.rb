# == Schema Information
#
# Table name: products
#
#  id            :integer         not null, primary key
#  name          :string(255)
#  description   :string(255)
#  price         :string(255)
#  collection_id :integer
#  created_at    :datetime        not null
#  updated_at    :datetime        not null
#  product_image :string(255)
#  url           :string(255)
#

require 'file_size_validator'
class Product < ActiveRecord::Base
	attr_accessible :name, :description, :price, :product_image, :remote_image_url, :url
	belongs_to :collection
	mount_uploader :product_image, ImageUploader
	make_flaggable :like

	validates :name, 			presence: true, length: { maximum: 100 }
	validates :description, 	presence: true, length: { maximum: 200 }
	validates :price,			length: { maximum: 10 }
	validates :collection_id,	presence: true
	validates :product_image,	file_size: { maximum: 2.megabytes.to_i }

end
