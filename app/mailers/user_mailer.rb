class UserMailer < ActionMailer::Base
	default from: "Ruuva Team <hello@ruuva.com>"

	def registration_mail(user)
		@user = user
		mail(to: "#{user.name} <#{user.email}>", subject: "Hello from the Ruuva Team!")
	end
end
