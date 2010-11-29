module Gifty 
  module Api
    module Operations
      module Social
        
        def share_twitter(event_id)
          response = get("/api/users/#{self.user_id}/event/#{event_id}/social/share_twitter")
          parse(response)
        end
        
        def share_facebook(event_id)
          response = get("/api/users/#{self.user_id}/event/#{event_id}/social/share_facebook")
          parse(response)
        end
        
      end
    end
  end
end