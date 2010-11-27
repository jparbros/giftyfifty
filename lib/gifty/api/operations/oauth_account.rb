module Gifty
  module Api
    module Operations
      module OauthAccount
        
        def all_accounts
          response = get "/api/users/#{self.user_id}/oauth_accounts/all_accounts"
          parse(response) 
        end
        
        def new_account(params)
          account_params = {}
          params.collect{|t| account_params["oauth_account[#{t[0]}]"] = t[1] }
          response = post("/api/users/#{self.user_id}/oauth_accounts", account_params)
          parse(response)
        end
        
      end
    end
  end
end