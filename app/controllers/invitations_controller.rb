class InvitationsController < ApplicationController

  def new

  end

  def create
    event = Event.find(params[:event_id])
    if EventMailer.invite(event, params[:emails]).deliver
      message_output = 'Your intitations was sended.'
    else
      message_output =  'There was a problem sending the invitations.'
    end
    growl_message message_output
    redirect_to event_path(event)
  end
  
  def twitter
  end
  
  def facebook
  end
end
