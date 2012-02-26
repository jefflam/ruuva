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

require 'file_size_validator'
class User < ActiveRecord::Base
	attr_accessible :name, :email, :password, :password_confirmation, :user_bio, 
					:shop, :cover_photo, :avatar, :remote_avatar_url, :password_digest 
					# Note: made password_digest attr_accessible only so we can set it in authentication
					# controller under update method when creating a new omniauth user
					# However, there is no option for user to edit password, so no way of accessing/editing/using
					# or even comparing password digest with any password fields. ie. user can't login with
					# email account from omniauth account and password_digest field.
	has_secure_password
	mount_uploader :cover_photo, ImageUploader
	mount_uploader :avatar, ImageUploader

	make_flagger

	scope :shop, where(shop: true)

	has_many :authentications
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
	validates :password, presence: true, length: { minimum: 6 } unless :account_from_omniauth? # Validation to bypass password hash if oauth
	validates :user_bio, length: { maximum: 200 }
	validates :cover_photo,	file_size: { maximum: 2.megabytes.to_i } 
	validates :avatar,	file_size: { maximum: 2.megabytes.to_i }

	def account_from_omniauth?
		self.authentications.empty?
	end

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
