ActionMailer::Base.smtp_settings = {
  :address              => "smtp.gmail.com",
  :port                 => 587,
  :domain               => 'giftyfifty.com',
  :user_name            => 'sendgrid@giftyfifty.com',
  :password             => 'Sendgrid1',
  :authentication       => 'plain',
  :enable_starttls_auto => true  
}