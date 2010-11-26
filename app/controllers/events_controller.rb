class EventsController < ApplicationController
  before_filter :authenticate_user!, :except => [:show]
  
  def create
    gift_url = params['gift-url'] || session['gift-url']
    if gift_url
      @event = current_user.gateway.new_event(gift_url)
    end
    session[:recent_event] = @event
    redirect_to edit_event_path(@event['event']['id'])
  end
  
  def edit
    @occasions = current_user.gateway.all_occasions
    @occasions = @occasions.collect {|occasion| [occasion['occasion']['name'].humanize,occasion['occasion']['id']]}
    unless @event['event']['id'] == params[:id]
      @event = current_user.gateway.show_event(params[:id])
    end
  end
  
  def show
    @event = gateway.show_event(params[:id])
    @occassion =  gateway.show_occasion(@event['event']['occasion'])
  end
  
  def update
    event_params = {}
    params[:event].collect{|t| event_params["event[#{t[0]}]"] = t[1] }
    current_user.gateway.update_event(event_params.merge(:id =>params[:id]))
    redirect_to event_path(params[:id])
  end
end
