module Gifty
  module Api
    module Operations
      module Occasion
        
        def all_occasions
          response = get("/api/occasions/all")
          parse(response)
        end
        
        def show_occasion(occasion_id)
          response = get("/api/occasions/#{occasion_id}")
          parse(response)
        end
        
      end
    end
  end
end