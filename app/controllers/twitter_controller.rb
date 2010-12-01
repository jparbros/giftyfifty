class TwitterController < ApplicationController
  def create
    event = current_user.events.where(:id => params[:event_id])
    event.share_on_twitter
    redirect_to user_event_path(current_user, event)
  end
end
