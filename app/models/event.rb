# == Schema Information
#
# Table name: events
#
#  id            :integer         not null, primary key
#  description   :string(255)
#  collection_id :integer
#  created_at    :datetime        not null
#  updated_at    :datetime        not null
#  date_time     :datetime
#

class Event < ActiveRecord::Base
	attr_accessible :description, :date_time
	belongs_to :collections
	make_flaggable :attending
	has_many :attending, as: :flaggings, dependent: :destroy

	validates :date_time, presence: true
	validates :description, length: { maximum: 500 }
	validates :collection_id, presence: true
end
