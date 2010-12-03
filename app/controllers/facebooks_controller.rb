class FacebooksController < ApplicationController
  def create
    event = current_user.events.where(:id => params[:event_id]).first
    event.share_on_facebook(event_url(current_user, event),params[:message])
    redirect_to event_path(current_user, event)
  end
end
