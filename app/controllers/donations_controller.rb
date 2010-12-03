class DonationsController < ApplicationController
  before_filter :authenticate_user!
  #before_filter :valid_user, :except => [:confirm, :validate]
  
  def confirm
    @user = User.new
  end
  
  def validate
    session[:user_email] = params[:user][:email]
    session[:user_password] = params[:user][:password]
    redirect_to new_donation_path(params[:event_id])
  end
  
  def new
    @donation = Donation.new
  end
  
  def create
    @donation = current_user.donations.new params[:donation].merge({:ip => request.env["HTTP_X_FORWARDED_FOR"],:event_id => params[:event_id]})
    if @donation.donate!
      redirect_to show_donation_path(params[:event_id], @donation)
    else
      flash[:notice] = 'The credit card is not valid.'
    end
  end
  
  def show
    clear_validate
    @donation = Donation.find(params[:id])
  end
  
  private
  
  def valid_user
    unless current_user.valid_to_donate?(session[:user_password],session[:user_email])
      redirect_to donation_confirm_path
    end
  end
  
  def clear_validate
    session[:user_email] = nil
    session[:user_password] = nil
  end
  
end