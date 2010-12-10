class Donation < ActiveRecord::Base
  #
  # Associations
  #
  belongs_to :event
  
  #
  # Attributes Accesors
  #
  attr_accessor :name, :credit_card, :expiration_date, :ip, :verification_value, :amount
  
  
  #
  # Callbacks
  #
  after_initialize :amaunt_to_cents 
  before_create :calculate_fees
  
  require 'gifty/cc'
  include ActiveMerchant::Billing
  include Gifty::Cc
  
  Base.mode = :test #(Rails.env.production? ? :production : :test)
  
  def donate!
    cc = CreditCard.new(formated_params)
    if cc.valid?
      result = gateway.purchase(self.donation, cc, {:ip => self.ip})
      if result.success?
        self.save
      else
        false
      end
    else
      'Not valid'
    end
  end
  
  private
  def gateway
    @gateway ||= PaypalGateway.new(
      :login => PAYPAL[:api_login],
      :password => PAYPAL[:api_password],
      :signature => PAYPAL[:api_signature]
    )
  end
  
  def calculate_fees
    self.payment_fees = (self.donation * 0.0229) + 30
    self.internal_fees = (self.donation * 0.05)
    self.total = self.donation - self.payment_fees - self.internal_fees
  end
  
  def amaunt_to_cents
    self.donation = (self.amount.to_i * 100)
  end
  
end
