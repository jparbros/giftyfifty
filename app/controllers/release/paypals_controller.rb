class Release::PaypalsController < ApplicationController
  def create
    @event = Event.find(params[:event_id])
    release = @event.build_release
    if release.paypal(params[:email])
    else
    end
    redirect_to event_path(@event)
  end
end
