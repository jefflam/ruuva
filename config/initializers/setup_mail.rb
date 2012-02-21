ActionMailer::Base.smtp_settings = {
  :address              => "smtp.gmail.com",
  :port                 => 587,
  :domain               => "ruuva.com",
  :user_name            => "hello@ruuva.com",
  :password             => "Sa&7dnFu",
  :authentication       => "plain",
  :enable_starttls_auto => true
}

ActionMailer::Base.default_url_options[:host] = "ruuva.com"
