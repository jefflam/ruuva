class UserMailer < ActionMailer::Base
	default from: "Ruuva Team <hello@ruuva.com>"

	def registration_mail(user)
		@user = user
		mail(to: "#{user.name} <#{user.email}>", subject: "Hello from the Ruuva Team!")
	end

	def event_reminder_mail
		@users = User.all
		@events_happening_soon = Event.all(conditions: ["date_time = ?", Time.now - 1.hour])
		@events_happening_soon.each do |e|
			Event.find_by_id(e.id)
			@users.each do |u|
				if u.flagged?(e, :attending)
					UserMailer.send_event_reminder_mail(u).deliver
				end
			end
		end
	end

	def send_event_reminder_mail(user)
		@user = user
		@events_happening_soon = Event.all(conditions: ["date_time = ?", Time.now - 1.hour])
		@events_happening_soon.each do |e|
			@event = Event.find_by_id(e.id)
			@collection = Collection.find_by_id(@event.collection_id)
		end		
		mail(to: "#{user.name} <#{user.email}>", subject: "A gentle reminder for your upcoming event...")		
	end
end
