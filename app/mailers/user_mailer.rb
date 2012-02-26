class UserMailer < ActionMailer::Base
	default from: "Ruuva Team <hello@ruuva.com>"

	def registration_mail(user)
		@user = user
		mail(to: "#{user.name} <#{user.email}>", subject: "Hello from the Ruuva Team!")
	end

	def self.event_reminder_mail
		@users = User.all
		# events_happening_soon only detected WITHIN one hour of it happening from Time.now
		@events_happening_soon = Event.all(conditions: ["date_time < ?", Time.now - 1.hour]) && Event.all(conditions: ["date_time > ?", Time.now - 2.hour])
		@events_happening_soon.each do |event|
			Event.find_by_id(event.id)
			@users.each do |user|
				if user.flagged?(event, :attending)
					puts "Reminder sent!" if UserMailer.send_event_reminder_mail(user).deliver
				end
			end
		end
	end

	def send_event_reminder_mail(user)
		@user = user
		@events_happening_soon = Event.all(conditions: ["date_time < ?", Time.now - 1.hour]) && Event.all(conditions: ["date_time > ?", Time.now - 2.hour])
		@events_happening_soon.each do |event|
			@event = event 											# Note: these declared variables don't 
			@collection = Collection.find(@event.collection_id)		# seem to pass through to email successfully yet...
		end		
		mail(to: "#{user.name} <#{user.email}>", subject: "A gentle reminder for your upcoming event...")		
	end
end
