module Gifty
  module Api
    module Operations
      module Event

        def new_event(url)
          response = get("/api/events/new?url=#{url}&user_id=#{self.user_id}")
          parse(response)
        end

        def recent_event
          response = get("/api/events/recent_event")
          parse(response)
        end
        
        def show_event(event_id)
          response = get("/api/events?event_id=#{event_id}")
          parse(response)
        end
        
        def update_event(event_params)
          response = put("/api/events", event_params)
          parse(response)
        end

      end
    end
  end
end