class Release::EbaysController < ApplicationController
  def create
    @event = Event.find(params[:event_id])
    release = @event.build_release
    if release.ebay(request.env["HTTP_X_FORWARDED_FOR"])
    else
    end
    redirect_to event_path(@event)
  end
end
