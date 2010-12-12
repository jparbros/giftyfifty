class Paypal
  
  def hash2cgiString(h)
    h.each { |key,value| h[key] = CGI::escape(value.to_s) if (value) }   
    h.map { |a| a.join('=') }.join('&')
  end
end