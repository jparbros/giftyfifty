PAYPAL = {
  :api_login => ENV['PAYPAL_API_LOGIN'],
  :api_password => ENV['PAYPAL_API_PASSWORD'],
  :api_signature => ENV['PAYPAL_API_SIGNATURE'],
  :api_url => ENV['PAYPAL_API_HTTP']
}

require 'gifty/paypal'