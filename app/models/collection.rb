# == Schema Information
#
# Table name: collections
#
#  id          :integer         not null, primary key
#  name        :string(255)
#  description :string(255)
#  user_id     :integer
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#  image       :string(255)
#

class Collection < ActiveRecord::Base
	attr_accessible :name, :description, :image, :remote_image_url
	belongs_to :user
	mount_uploader :image, ImageUploader

	validates :name, 		presence: true, length: { maximum: 100 }
	validates :description, presence: true, length: { maximum: 200 }
	validates :image,		presence: true 
	validates :user_id, 	presence: true


end
