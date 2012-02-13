# == Schema Information
#
# Table name: users
#
#  id              :integer         not null, primary key
#  email           :string(255)
#  password_digest :string(255)
#  created_at      :datetime        not null
#  updated_at      :datetime        not null
#  name            :string(255)
#  user_bio        :string(255)
#  admin           :boolean         default(FALSE)
#  shop            :boolean         default(FALSE)
#  avatar          :string(255)
#  cover_photo     :string(255)
#

class User < ActiveRecord::Base
	attr_accessible :name, :email, :password, :password_confirmation, :user_bio, 
					:shop, :cover_photo, :avatar, :remote_image_url
	has_secure_password
	mount_uploader :cover_photo, ImageUploader
	mount_uploader :avatar, ImageUploader

	scope :shop, where(shop: true)

	has_many :posts, 					dependent: :destroy
	has_many :relationships,		 	dependent: :destroy,
										foreign_key: "follower_id"
	has_many :reverse_relationships,	dependent: :destroy,
										foreign_key: "followed_id",
										class_name: "Relationship"
									
	has_many :following, through: :relationships, source: :followed	
	has_many :followers, through: :reverse_relationships, source: :follower	
	
	has_many :collections,				dependent: :destroy	

	validates :name, presence: true, length: { maximum: 50 }
	valid_email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, 	presence: true, 
						format: { with: valid_email_regex },
						uniqueness: { case_sensitive: false }
	validates :password, presence: true, length: { minimum: 6 }
	validates :user_bio, length: { maximum: 200 }

	def feed
		Post.from_users_followed_by(self)
	end

	def following?(followed)
		relationships.find_by_followed_id(followed)
	end

	def follow!(followed)
		relationships.create!(followed_id: followed.id)		
	end

	def unfollow!(followed)
		relationships.find_by_followed_id(followed).destroy
	end
end
