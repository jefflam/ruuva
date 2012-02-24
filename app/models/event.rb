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

	validates :date_time, presence: true
	validates :description, length: { maximum: 500 }
	validates :collection_id, presence: true

	# code not working; --trace says uninitialized constant Event
	def self.delete_events
		@events_delete = Event.all(conditions: ["date_time < ?", Time.now - 6.hours])
		@events_delete.each do |event|
			puts "deleted" if event.delete
		end
	end
end
