module Gifty
  module Api
    module Operations
      module OauthAccount
        
        def all_accounts
          response = get "/api/users/#{self.user_id}/oauth_accounts/all_accounts"
          parse(response) 
        end
        
      end
    end
  end
end