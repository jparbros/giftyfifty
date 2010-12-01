class TwittersController < ApplicationController
  def create
    event = current_user.events.where(:id => params[:event_id]).first
    event.share_on_twitter
    redirect_to user_event_path(current_user, event)
  end
end
