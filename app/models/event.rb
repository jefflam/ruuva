# == Schema Information
#
# Table name: events
#
#  id            :integer         not null, primary key
#  date          :integer
#  time          :integer
#  description   :string(255)
#  collection_id :integer
#  created_at    :datetime        not null
#  updated_at    :datetime        not null
#

class Event < ActiveRecord::Base
	attr_accessible :date, :time, :description
	belongs_to :collections
	make_flaggable :attending

	validates :date, presence: true
	validates :time, presence: true
	validates :description, length: { maximum: 500 }
	validates :collection_id, presence: true
end
