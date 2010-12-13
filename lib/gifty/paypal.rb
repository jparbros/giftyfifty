module Gifty
  class Paypal
  
    def hash2cgiString(h)
      h.each { |key,value| h[key] = CGI::escape(value.to_s) if (value) }   
      h.map { |a| a.join('=') }.join('&')
    end
  
    def call(method, params)
      @query = hash2cgiString(authentification_params.merge({:method => method}.merge(params)))
      http = Net::HTTP.new(PAYPAL[:api_url], 443)
      http.use_ssl = true
      puts @query
      response = http.post('/nvp', @query)
      data = CGI::parse(response.body)
      Transaction.new(data)
    end
  
    def authentification_params
      params = {}
      params['USER'] = PAYPAL[:api_login]
      params['PWD'] = PAYPAL[:api_password]
      params['SIGNATURE'] = PAYPAL[:api_signature]
      params['VERSION'] = '65.0'
      params
    end
  end

  class Transaction       
    def initialize(data)
     @success = data["ACK"].to_s != "Failure"
     @response = data    
   end
    def success?
      @success
    end
    def response
      @response
    end
  end
end