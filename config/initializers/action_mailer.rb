ActionMailer::Base.smtp_settings = {
  :address        => "mail.cgb.im",
  :port           => "2525",
  :authentication => :plain,
  :user_name      => ENV["SANTA_MAILER_USERNAME"],
  :password       => ENV["SANTA_MAILER_PASSWORD"],
  :enable_starttls_auto => false
}