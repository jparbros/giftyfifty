class EventsController < ApplicationController
  before_filter :authenticate_user!, :except => [:show]
  
  def create
    @event = current_user.events.new(:url => params['gift-url'])
    if @event.save
      redirect_to edit_user_event_path(current_user, @event)
    else
      render :new
    end
  end
  
  def edit
    @event = current_user.events.find(params[:id])
    @occasions = Occasion.all.collect {|occasion| [occasion.name,occasion.id]}
  end
  
  def show
    @event = Event.find(params[:id])
  end
  
  def update
    @event = current_user.events.find(params[:id])
    if @event.update_attributes(params[:event])
      redirect_to user_event_path(current_user,@event)
    else
      render :edit
    end
  end
end
