class EventMailer < ActionMailer::Base  
  def invite(event, emails_friends)
    @event = event
    mail(:to => emails_friends, :subject => "GiftyFifty!")
  end
end
