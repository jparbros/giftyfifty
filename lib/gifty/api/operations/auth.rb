module Gifty
  module Api
    module Operations
      class Auth < Gifty::Api::Request
        
        REQUEST_PARAMETERS = :consumer_key, :consumer_secret
        
        REQUEST_PARAMETERS.each do |param|
          self.send(:attr_accessor, param)
        end
        
        def initialize
          self.request_path = 'auth'
          self.consumer_key = Gifty::Api::Base::consumer_key
          self.consumer_secret = Gifty::Api::Base::consumer_secret
        end
        
        def authorize
          self.action_path = 'new'
          self.run
        end
        
        protected
        
        def request_paramameters
          REQUEST_PARAMETERS.inject({}) do |parameters, parameter|
            parameters[parameter] = eval("self.#{parameter}") unless eval("self.#{parameter}.nil?")
            parameters
          end
        end
      end
    end
  end
end