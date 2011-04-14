require 'rack/utils'

class EventUrl
  def initialize(app)
    @app = app
  end
  
  def call(env)
    request = Rack::Request.new(env)
    if request.params['gift_url'] && request.params['from_main'] == 'true'
      request.session['gift_url'] = request.params['gift_url']
    end
    @app.call(env)
  end
  
  
end