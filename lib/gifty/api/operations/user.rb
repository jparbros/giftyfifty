module Gifty 
  module Api
    module Operations
      class User 
        
        attr_accessor :user_id
                
        # REQUEST_PARAMETERS.each do |param|
        #           self.send(:attr_accessor, param)
        #         end
        
        def initialize
          self.request_path = 'users'
        end
        
        def new_user(user_params)
          self.action_path = 'new'
        end
        
        protected
        
        def valid_params?(params)
          params['user'] and params['user']['first_name'] and params['user']['last_name'] and params['user']['email'] and params['user']['password']
        end
        
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