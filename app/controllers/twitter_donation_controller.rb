class TwitterDonationController < ApplicationController
  def create
    event = Event.find(params[:event_id])
    message = current_user.share_donation_message(event)
    if current_user.twitter_share(message)
      message_output = 'Your message was posted on Twitter.'
    else
      message_output =  'There was a problem posting the message on Twitter.'
    end
    growl_message message_output
    redirect_to event_path(event)
  end
end
