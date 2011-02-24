class Donation < ActiveRecord::Base
  #
  # Associations
  #
  belongs_to :event
  belongs_to :user
  
  #
  # Attributes Accesors
  #
  attr_accessor :name, :credit_card, :month, :year, :ip, :verification_value, :amount
  
  
  #
  # Callbacks
  #
  after_initialize :amaunt_to_cents 
  before_create :calculate_fees
  after_create :check_donation_amount
  
  #
  # Constants
  #
  
  MONTHS = [['Jan','1'],['Feb','2'],['Mar','3'],['Apr','4'],['May','5'],['Jun','6'],['Jul','7'],['Aug','8'],['Sep','9'],['Oct','10'],['Nov','11'],['Dec','12']]
  
  require 'gifty/cc'
  include ActiveMerchant::Billing
  include Gifty::Cc
  
  Base.mode = :test #(Rails.env.production? ? :production : :test)
  
  def self.years
    _years = []
    for i in Time.now.year.to_i..Time.now.year.to_i+15
      _years << i
    end
    _years
  end
  
  def donate!
    cc = CreditCard.new(formated_params)
    if cc.valid? and self.event.active?
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
  
  def donation_amount
    (self.total/100.00).to_f
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
  
  def check_donation_amount
    event.donations_completed? 
  end
  
end
