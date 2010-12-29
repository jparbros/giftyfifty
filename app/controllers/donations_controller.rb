class DonationsController < ApplicationController
  before_filter :authenticate_user!, :except => [:show]

  def new
    @donation = Donation.new
  end
  
  def create
    @donation = current_user.donations.new params[:donation].merge({:ip => request.env["HTTP_X_FORWARDED_FOR"],:event_id => params[:event_id]})
    if @donation.donate!
      redirect_to event_donation_path(params[:event_id], @donation)
    else
      growl_message 'The credit card is not valid.'
      redirect_to new_event_donation_path
    end
  end
  
  def show
    clear_validate
    @donation = Donation.find(params[:id])
  end
    
end
