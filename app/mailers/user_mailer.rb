class UserMailer < ActionMailer::Base
  default :from => "no-reply@giftyfifty.com"
  
  def register_confirmation(user)
    @user = user
    mail(:to => user.email, :subject => "Welcome to GiftyFifty!")
    headers('Content-Type' => 'text/html')
  end
  
  def test
    mail(:to => 'jparbros@hotmail.com', :subject => "Welcome to GiftyFifty!")
    headers('Content-Type' => 'text/html') 
  end
end
