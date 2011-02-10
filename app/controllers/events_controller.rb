class EventsController < ApplicationController
  before_filter :authenticate_user!, :except => [:show, :new]
  
  def new
    @event = Event.new
    @event.build_item
    @occasions = Occasion.all.collect {|occasion| [occasion.name.humanize,occasion.id]}
  end
  
  def create
    begin
      if current_user.active_events.blank?
        if current_user.new_events.blank?
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
          growl_message 'You have an new active. Not is possible create another until the actual event finish.'
          redirect_to edit_event_url(current_user.new_events.first)
        end
      else
        growl_message 'You have an event active. Not is possible create another until the actual event finish.'
        redirect_to event_url(current_user.active_events.first)
      end
    rescue
      growl_message 'The url is not valid.<br/> Please enter a url from any product of amazon or ebay.'
      redirect_to new_event_url
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
      if current_user.profile_copleted?
        @event.activate!
        redirect_to event_path(@event)
      else
        redirect_to edit_user_registration_url(current_user)
      end
    else
      render :edit
    end
  end
end
