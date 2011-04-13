ActionMailer::Base.smtp_settings = {
  :address              => "smtp.sendgrid.net",
  :port                 => 25,
  :domain               => 'giftyfifty.com',
  :user_name            => 'jorge@giftyfifty.com',
  :password             => '271185',
  :authentication       => 'plain',
}