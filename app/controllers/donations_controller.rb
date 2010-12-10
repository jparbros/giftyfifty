class DonationsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :valid_user, :only => [:new, :create]
  
  def confirm
    @user = User.new
  end
  
  def validate
    session[:user_email] = params[:user][:email]
    session[:user_password] = params[:user][:password]
    redirect_to new_event_donation_path(params[:event_id])
  end
  
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
  
  private
  
  def valid_user
    unless current_user.valid_to_donate?(session[:user_password],session[:user_email])
      redirect_to confirm_donation_path(params[:event_id])
    end
  end
  
  def clear_validate
    session[:user_email] = nil
    session[:user_password] = nil
  end
  
end
