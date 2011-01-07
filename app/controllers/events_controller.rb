class EventsController < ApplicationController
  before_filter :authenticate_user!, :except => [:show, :new]
  
  def new
    @event = Event.new
    @event.build_item
    @occasions = Occasion.all.collect {|occasion| [occasion.name.humanize,occasion.id]}
  end
  
  def create
    begin
      if current_user.active_event.blank?
        if params[:event]
          @event = current_user.events.new(params[:event])
        else
          @event = current_user.events.new(:url => params['gift_url'])
        end
        if @event.save
          if @event.manual 
            redirect_to event_path(@event)
          else
            redirect_to edit_event_path(@event)
          end
        end
      else
        growl_message 'You have an event active. Not is possible create another until the actual event finish.'
        redirect_to :root
      end
    rescue
      growl_message 'The url is not valid.<br/> Please enter a url from any product of amazon or ebay.'
      redirect_to :root
    end
  end
  
  def edit
    @event = current_user.events.find(params[:id])
    @occasions = Occasion.all.collect {|occasion| [occasion.name.humanize,occasion.id]}
  end
  
  def show
    @event = Event.find(params[:id])
  end
  
  def update
    @event = current_user.events.find(params[:id])
    if @event.update_attributes(params[:event])
      redirect_to event_path(@event)
    else
      render :edit
    end
  end
end
