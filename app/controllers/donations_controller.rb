class DonationsController < ApplicationController
  before_filter :authenticate_user!, :except => [:show]

  def new
    @donation = Donation.new
    @event = Event.find(params[:event_id])
    redirect_to event_path(@event) unless @event.active?
  end
  
  def create
    if params[:payment_method] == 'credit_card'
      @donation = current_user.donations.new params[:donation].merge({:ip => request.env["HTTP_X_FORWARDED_FOR"],:event_id => params[:event_id]})
      if @donation.donate! == true
        redirect_to event_url(params[:event_id], :donation => true)
      else
        growl_message 'The credit card is not valid.'
        redirect_to new_event_donation_path
      end
    else
      event = Event.find(params[:event_id])
      paypal = Gifty::Paypal.new
      response = paypal.call('SetExpressCheckout',{
          :PAYMENTREQUEST_0_AMT => params[:donation][:amount], 
          :RETURNURL => event_url(params[:event_id], :donation => true), 
          :CANCELURL => new_event_donation_url(:event_id => params[:event_id]),
          :PAYMENTREQUEST_0_DESC => "Gifty Fifty: Donation to #{event.user.name}'s gift."
      })
      if response.success?
        redirect_to "https://www.sandbox.paypal.com/webscr?cmd=_express-checkout&token=#{response.response['TOKEN'].first}"
      else
        growl_message 'An error occurred processing your payment.'
        redirect_to new_event_donation_url(event)
      end
    end
  end
  
  def show
    @donation = Donation.find(params[:id])
  end
  
  def ipn
    paypal = Gifty::Paypal.new
    response = paypal.call('GetExpressCheckoutDetails', {:TOKEN => params[:token]})
    if response.success?
      donation = Donation.new(:amount => response.response['PAYMENTREQUEST_0_AMT'].first.to_i, :user => current_user, :event_id => params[:event_id])
      if donation.save
        redirect_to event_donation_url(:event_id => params[:event_id], :id => donation.id)
      else
        growl_message 'An error occurred processing your payment. Please contact with customer support: support@giftyfifty.com'
        new_event_donation_url(:event_id => params[:event_id])
      end
    else
      growl_message 'An error occurred processing your payment. Please contact with customer support: support@giftyfifty.com'
      new_event_donation_url(:event_id => params[:event_id])
    end
  end
    
end
