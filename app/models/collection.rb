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

require 'file_size_validator'
class Collection < ActiveRecord::Base
	attr_accessible :name, :description, :image, :remote_image_url
	belongs_to :user
	has_many :products,		dependent: :destroy
	has_many :events,		dependent: :destroy
	mount_uploader :image, ImageUploader
	make_flaggable :like


	validates :name, 		presence: true, length: { maximum: 100 }
	validates :description, presence: true, length: { maximum: 200 }
	validates :image,		presence: true 
	validates :user_id, 	presence: true
	validates :image,	file_size: { maximum: 2.megabytes.to_i }

end
