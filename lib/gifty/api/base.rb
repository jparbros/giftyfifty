module Gifty
  module Api
    class Base
      
      attr_accessor :user_id
      
      include Gifty::Api::Request
      include Gifty::Api::Operations::Event
      include Gifty::Api::Operations::Occasion
      include Gifty::Api::Operations::OauthAccount
      include Gifty::Api::Operations::User
      
    end
  end
end