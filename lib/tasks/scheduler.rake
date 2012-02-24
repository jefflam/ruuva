desc "This task is called by the Heroku scheduler add-on"
# code not working; --trace says uninitialized constant Event; to add => :environment
task :delete_events => :environment do
	Event.delete_events
end

task :event_reminder_mail => :environment do
	UserMailer.event_reminder_mail
end