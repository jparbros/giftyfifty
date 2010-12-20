class Release::PaypalsController < ApplicationController
  def create
    @event = Event.find(params[:event_id])
    release = @event.build_release
    if release.paypal(params[:release][:email])
      message_output = 'The release of the gift was successfully.'
    else
      message_output = 'There was a problem releasing the gift. <br /> Please contact with customer support.'
    end
    growl_message message_output
    redirect_to event_path(@event)
  end
end
