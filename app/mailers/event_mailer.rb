class EventMailer < ActionMailer::Base
  default :from => "no-reply@giftyfifty.com"
  
  def invite(event, emails_friends)
    @event = event
    mail(:to => emails_friends, :subject => "GiftyFifty!")
  end
end
