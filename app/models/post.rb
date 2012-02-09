# == Schema Information
#
# Table name: posts
#
#  id         :integer         not null, primary key
#  content    :string(255)
#  user_id    :integer
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

class Post < ActiveRecord::Base
	attr_accessible :content
	belongs_to :user

	validates :content, presence: true, length: { maximum: 500 }
	validates :user_id, presence: true

	default_scope order: 'posts.created_at DESC'

	scope :from_users_followed_by, lambda { |user| followed_by(user) }

	private

	def self.followed_by(user)
		following_ids = %(SELECT followed_id FROM relationships WHERE follower_id = :user_id)
		where("user_id IN (#{following_ids}) OR user_id = :user_id", user_id: user)
	end

end
