module Gifty
  module Api
    module Request
      
      def consumer
        @consumer ||= OAuth::Consumer.new OAUTH_CREDENTIALS[:key], OAUTH_CREDENTIALS[:secret], OAUTH_CREDENTIALS[:options]
      end
            
      def request_token
        @request_token ||= consumer.get_request_token
      end
      
      def request_token_authorized
        if @request_token.nil?
          response = Net::HTTP.get(URI.parse("http://#{OAUTH_CREDENTIALS[:options][:site].gsub(/^.*\/\//,'')}/oauth/post_authorize?oauth_token=#{request_token.params[:oauth_token]}&authorize=1"))
          params = CGI::parse(response)
          @request_token = OAuth::RequestToken.from_hash(consumer, {:oauth_token => params['oauth_token'],:oauth_token_secret => params['oauth_token_secret']})
        end
      end
      
      def access_token
        @access_token ||= request_token.get_access_token
      end
      
      def access_token=(token)
        @access_token = token
      end
      
      def get(path, headers = {})
        access_token.get(path, headers)
      end
      
      def post(path, body = '', headers = {})
        access_token.post(path, body, headers)
      end
      
      def delete(path, headers = {})
        access_token.delete(path, headers)
      end
      
      def put(path, body = '', headers = {})
        access_token.put(path, body, headers)
      end
      
      def parse(result)
        JSON.parse(result.body).first
      end
      
    end
  end
end