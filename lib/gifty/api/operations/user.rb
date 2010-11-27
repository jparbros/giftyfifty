module Gifty 
  module Api
    module Operations
      module User 
        
        def new_user(user_params)
          event_params = {}
          user_params.collect{|t| event_params["user[#{t[0]}]"] = t[1] }
          response = post("/api/users", event_params)
          parse(response)
        end
        
      end
    end
  end
end