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

	def delete_events
		@events_delete = self.all(conditions: ["date_time < ?", Time.now - 6.hours])
		@events_delete.each do |e|
			self.find_by_id(e.id).delete
		end
	end
end
