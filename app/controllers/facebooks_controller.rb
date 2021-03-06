class FacebooksController < ApplicationController
  def create
    event = current_user.events.where(:id => params[:event_id]).first
    if event.share_on_facebook(params[:facebook_message])
      message_output = 'Your message was posted on Facebook.'
    else
      message_output =  'There was a problem posting the message on Facebook.'
    end
    growl_message message_output
    redirect_to event_path(event)
  end
end
